import { type Prisma } from '@prisma/client';
import { type TokenSet } from 'next-auth';
import qs from 'querystring';

import * as fetch from '@/utils/fetch';

export type KeycloakProps = {
  realm: string;
  host: string;
  clientId: string;
  clientSecret: string;
};

export type SearchProps = {
  scope: string;
  type: Prisma.ModelName;
};

export type ResourceProps = {
  name: string;
  type: string;
  resource_scopes: string[];
};

export type EditProps = {
  _id: string;
  name: string;
  owner: {
    id: string;
    name: string;
  };
  ownerManagedAccess: false;
  displayName: string;
  attributes?: {
    [k: string]: string[];
  };
  uris: [];
  scopes: { id: string; name: string }[];
};

export type PermissionProps = {
  resourceId: string;
  scope: string;
};

export type ReturnToken = {
  access_token: string;
  expires_in: number;
  refresh_expires_in: number;
  refresh_token: string;
  token_type: string;
  'not-before-policy': number;
  session_state: string;
  scope: string;
};

export type KeycloakError = {
  error: string;
  error_description: string;
};

export type KeycloakResponse = {
  name: string;
  owner: { id: string; name: string };
  ownerManagedAccess: boolean;
  _id: string;
  uris: string[];
  resource_scopes: [
    {
      id: string;
      name: string;
    }
  ];
  scopes: [
    {
      id: string;
      name: string;
    }
  ];
};

export class Keycloak {
  props: KeycloakProps;
  constructor(props: KeycloakProps) {
    this.props = props;
  }

  get basePath() {
    return `${this.props.host}realms/${this.props.realm}/authz/protection/resource_set`;
  }

  async getClientToken() {
    const { realm, host, clientId, clientSecret } = this.props;

    const bodyJSON = {
      client_id: clientId,
      grant_type: 'client_credentials',
      client_secret: clientSecret,
    };

    const body = qs.stringify(bodyJSON);

    const response = await fetch.post<string, ReturnToken>(
      `${host}realms/${realm}/protocol/openid-connect/token`,
      body,
      {
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      }
    );

    return response.access_token;
  }

  async refreshToken(refresh_token: string) {
    const { realm, host, clientId, clientSecret } = this.props;

    const body = qs.stringify({
      client_id: clientId,
      client_secret: clientSecret,
      grant_type: 'refresh_token',
      refresh_token,
    });

    const response = await fetch.post<string, TokenSet>(
      `${host}realms/${realm}/protocol/openid-connect/token`,
      body,
      {
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      }
    );

    if (response.error === 'invalid_grant') {
      console.warn('Warning: Refresh token is outdated. Please login again.');
    }

    return response;
  }

  resource = {
    search: async (props: SearchProps) => {
      const search_param = qs.stringify(props, '&', '=', {
        encodeURIComponent(str) {
          return str;
        },
      });

      return await fetch.get<string[]>(`${this.basePath}?${search_param}`, {
        headers: {
          Authorization: `Bearer ${await this.getClientToken()}`,
        },
      });
    },

    create: async (props: ResourceProps) => {
      const headers = {
        headers: {
          Authorization: `Bearer ${await this.getClientToken()}`,
          'Content-Type': 'application/json',
        },
      };

      const result = await fetch.post<ResourceProps, KeycloakResponse>(
        `${this.basePath}`,
        props,
        headers
      );

      return result;
    },

    edit: async (id: string, props: EditProps) => {
      return await fetch.put<EditProps, KeycloakResponse>(
        `${this.basePath}/resource/${id}`,
        props,
        {
          headers: {
            Authorization: `Bearer ${await this.getClientToken()}`,
          },
        }
      );
    },

    delete: async (id: string) => {
      return await fetch.del<KeycloakResponse>(
        `${this.basePath}/resource/${id}`
      );
    },
  };
}
