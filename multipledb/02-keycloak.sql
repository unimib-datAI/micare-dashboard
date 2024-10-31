--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2 (Debian 13.2-1.pgdg100+1)
-- Dumped by pg_dump version 13.2 (Debian 13.2-1.pgdg100+1)
\c keycloak

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO keycloak;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO keycloak;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO keycloak;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO keycloak;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO keycloak;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO keycloak;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO keycloak;

--
-- Name: client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO keycloak;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.client_attributes OWNER TO keycloak;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO keycloak;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO keycloak;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO keycloak;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO keycloak;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO keycloak;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO keycloak;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO keycloak;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO keycloak;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO keycloak;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO keycloak;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO keycloak;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO keycloak;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO keycloak;

--
-- Name: component; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO keycloak;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE public.component_config OWNER TO keycloak;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO keycloak;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO keycloak;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO keycloak;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO keycloak;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO keycloak;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


ALTER TABLE public.event_entity OWNER TO keycloak;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE public.fed_user_attribute OWNER TO keycloak;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO keycloak;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO keycloak;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO keycloak;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO keycloak;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO keycloak;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO keycloak;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO keycloak;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO keycloak;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO keycloak;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO keycloak;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO keycloak;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO keycloak;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO keycloak;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO keycloak;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO keycloak;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO keycloak;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO keycloak;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO keycloak;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO keycloak;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO keycloak;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO keycloak;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO keycloak;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO keycloak;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO keycloak;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO keycloak;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO keycloak;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO keycloak;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO keycloak;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO keycloak;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO keycloak;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO keycloak;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO keycloak;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO keycloak;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO keycloak;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO keycloak;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO keycloak;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO keycloak;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO keycloak;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO keycloak;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO keycloak;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO keycloak;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO keycloak;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO keycloak;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO keycloak;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO keycloak;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO keycloak;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE public.user_attribute OWNER TO keycloak;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO keycloak;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO keycloak;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO keycloak;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO keycloak;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO keycloak;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO keycloak;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO keycloak;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO keycloak;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO keycloak;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO keycloak;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO keycloak;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO keycloak;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO keycloak;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO keycloak;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
87879993-638f-4d29-8c49-03db731c9c55	84e17510-6ac2-43d7-9665-fd37ca010d1f
260d3120-2d37-479f-aacf-c8e0d2b07831	f3dd65aa-ae61-4c95-bd19-771574c86113
1e9829ba-d270-40ba-90f8-a84217f40c55	aeff6316-09a6-42fe-8c34-f59cc2ae1c3c
4c6899c2-b082-4990-a1fd-378fe60807c6	2eb3054a-2aaa-4564-9534-de0406e0a980
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
12a36025-9965-4728-a758-bb2a8631ad5c	\N	auth-cookie	1cc45988-1774-48f1-af0c-82610082f679	b55a7f53-fa7b-4cbb-b05f-a35611337974	2	10	f	\N	\N
9ef07c35-8201-47a4-a14c-90f5e30b4f7c	\N	auth-spnego	1cc45988-1774-48f1-af0c-82610082f679	b55a7f53-fa7b-4cbb-b05f-a35611337974	3	20	f	\N	\N
68d5d3ac-1946-4d52-8287-89cc031f528f	\N	identity-provider-redirector	1cc45988-1774-48f1-af0c-82610082f679	b55a7f53-fa7b-4cbb-b05f-a35611337974	2	25	f	\N	\N
b671c5e5-3b6e-4f4a-a15b-580201ebcc46	\N	\N	1cc45988-1774-48f1-af0c-82610082f679	b55a7f53-fa7b-4cbb-b05f-a35611337974	2	30	t	bbd006b5-9e83-4f08-a0fe-0d38d081ab36	\N
9d03011a-7e6f-4923-b944-356acfdf8a4c	\N	auth-username-password-form	1cc45988-1774-48f1-af0c-82610082f679	bbd006b5-9e83-4f08-a0fe-0d38d081ab36	0	10	f	\N	\N
f41c54de-bbd0-47dd-b381-a472b185a91c	\N	\N	1cc45988-1774-48f1-af0c-82610082f679	bbd006b5-9e83-4f08-a0fe-0d38d081ab36	1	20	t	c29b1031-7415-4adb-8ee5-51f158874559	\N
c33a6a72-6caa-4732-82b1-ce4d2a87a47c	\N	conditional-user-configured	1cc45988-1774-48f1-af0c-82610082f679	c29b1031-7415-4adb-8ee5-51f158874559	0	10	f	\N	\N
814ba4d4-11f0-415b-9a2e-21c633a6ec97	\N	auth-otp-form	1cc45988-1774-48f1-af0c-82610082f679	c29b1031-7415-4adb-8ee5-51f158874559	0	20	f	\N	\N
0840b8f6-23ea-4c9b-b7de-f7bff80058ca	\N	direct-grant-validate-username	1cc45988-1774-48f1-af0c-82610082f679	ffca43b4-d63d-4533-b30c-2a837f9c6b94	0	10	f	\N	\N
741e77c8-f8ae-48a2-b3bd-e62edef845f3	\N	direct-grant-validate-password	1cc45988-1774-48f1-af0c-82610082f679	ffca43b4-d63d-4533-b30c-2a837f9c6b94	0	20	f	\N	\N
5c61eb74-f698-473f-8b12-7769213cdb92	\N	\N	1cc45988-1774-48f1-af0c-82610082f679	ffca43b4-d63d-4533-b30c-2a837f9c6b94	1	30	t	86268ffe-fd5d-4068-9ded-316ea986ece4	\N
0104b88a-98d8-4dd8-8847-89ef1b2f31e6	\N	conditional-user-configured	1cc45988-1774-48f1-af0c-82610082f679	86268ffe-fd5d-4068-9ded-316ea986ece4	0	10	f	\N	\N
66ec3636-9295-4b0d-900b-5158acbcf77f	\N	direct-grant-validate-otp	1cc45988-1774-48f1-af0c-82610082f679	86268ffe-fd5d-4068-9ded-316ea986ece4	0	20	f	\N	\N
b77ad9d0-6954-45de-8103-e5a0eae4a782	\N	registration-page-form	1cc45988-1774-48f1-af0c-82610082f679	d941d676-22db-4ff8-a265-518a4462c2b6	0	10	t	82867a26-a879-4671-a08e-ea9ea6014f05	\N
50f49875-6d77-43ff-8165-72da30cae751	\N	registration-user-creation	1cc45988-1774-48f1-af0c-82610082f679	82867a26-a879-4671-a08e-ea9ea6014f05	0	20	f	\N	\N
1f4eee32-1abd-4aee-bf5c-7ae140f5011e	\N	registration-profile-action	1cc45988-1774-48f1-af0c-82610082f679	82867a26-a879-4671-a08e-ea9ea6014f05	0	40	f	\N	\N
b0c168ff-fc5c-4bcd-937c-824955479abd	\N	registration-password-action	1cc45988-1774-48f1-af0c-82610082f679	82867a26-a879-4671-a08e-ea9ea6014f05	0	50	f	\N	\N
58612e42-8452-483f-b180-544232254ceb	\N	registration-recaptcha-action	1cc45988-1774-48f1-af0c-82610082f679	82867a26-a879-4671-a08e-ea9ea6014f05	3	60	f	\N	\N
ac2d6ddf-76d8-45e5-bb88-972749a928f1	\N	registration-terms-and-conditions	1cc45988-1774-48f1-af0c-82610082f679	82867a26-a879-4671-a08e-ea9ea6014f05	3	70	f	\N	\N
259c0945-0f36-41f4-bace-f64cf0cbc98e	\N	reset-credentials-choose-user	1cc45988-1774-48f1-af0c-82610082f679	c2f76612-011e-497c-888c-d00c280ffba5	0	10	f	\N	\N
17b9ec08-53b3-46cb-b676-5b835fbc0a26	\N	reset-credential-email	1cc45988-1774-48f1-af0c-82610082f679	c2f76612-011e-497c-888c-d00c280ffba5	0	20	f	\N	\N
009283ec-d1dd-4404-be5e-3e2989f4331a	\N	reset-password	1cc45988-1774-48f1-af0c-82610082f679	c2f76612-011e-497c-888c-d00c280ffba5	0	30	f	\N	\N
6cb198b9-4b58-4631-8e09-329f10bce862	\N	\N	1cc45988-1774-48f1-af0c-82610082f679	c2f76612-011e-497c-888c-d00c280ffba5	1	40	t	52a32fd1-803f-4812-8c73-d6df98aaf3c5	\N
d9eff776-2968-4a28-a3a4-5da797db59ad	\N	conditional-user-configured	1cc45988-1774-48f1-af0c-82610082f679	52a32fd1-803f-4812-8c73-d6df98aaf3c5	0	10	f	\N	\N
f6e40e27-2245-4f92-81b1-17f649d1a43d	\N	reset-otp	1cc45988-1774-48f1-af0c-82610082f679	52a32fd1-803f-4812-8c73-d6df98aaf3c5	0	20	f	\N	\N
6a3cf48b-b3a1-4811-b3cd-c201060c87aa	\N	client-secret	1cc45988-1774-48f1-af0c-82610082f679	ee300e14-5742-43c5-ab90-83014c3510a6	2	10	f	\N	\N
fe8888cc-d5d8-4874-b205-aaed6cf19eea	\N	client-jwt	1cc45988-1774-48f1-af0c-82610082f679	ee300e14-5742-43c5-ab90-83014c3510a6	2	20	f	\N	\N
545846a0-84b5-49e8-88a2-3547c68e394c	\N	client-secret-jwt	1cc45988-1774-48f1-af0c-82610082f679	ee300e14-5742-43c5-ab90-83014c3510a6	2	30	f	\N	\N
86fe6ca7-ee25-4a8f-89fb-300c2424364b	\N	client-x509	1cc45988-1774-48f1-af0c-82610082f679	ee300e14-5742-43c5-ab90-83014c3510a6	2	40	f	\N	\N
9f1c94e0-433b-4f59-85ee-57081cc05f56	\N	idp-review-profile	1cc45988-1774-48f1-af0c-82610082f679	edb995df-d59c-4ea2-b548-a664f044985e	0	10	f	\N	be1db97e-6976-43c5-83b0-3272d34fee20
5c6c9057-aa5a-4f2f-b167-b66209f25f09	\N	\N	1cc45988-1774-48f1-af0c-82610082f679	edb995df-d59c-4ea2-b548-a664f044985e	0	20	t	342efa59-e33e-4e32-9bdf-31a3eae92a57	\N
7b9be224-e240-4030-9d96-f6a38e96cbd5	\N	idp-create-user-if-unique	1cc45988-1774-48f1-af0c-82610082f679	342efa59-e33e-4e32-9bdf-31a3eae92a57	2	10	f	\N	0cc83cdf-6903-46b6-ba89-5245063b1dc7
f1252d6b-f941-47f1-b961-a12b9d30649a	\N	\N	1cc45988-1774-48f1-af0c-82610082f679	342efa59-e33e-4e32-9bdf-31a3eae92a57	2	20	t	57e1bbc2-b334-4f1e-915d-81c75221d1e2	\N
0d8d18a3-39ae-4da3-8c4d-b9b58f071ed6	\N	idp-confirm-link	1cc45988-1774-48f1-af0c-82610082f679	57e1bbc2-b334-4f1e-915d-81c75221d1e2	0	10	f	\N	\N
913f5e38-b131-4632-a42a-f648c9199d29	\N	\N	1cc45988-1774-48f1-af0c-82610082f679	57e1bbc2-b334-4f1e-915d-81c75221d1e2	0	20	t	e54eee87-0d08-474e-97a2-1c9def432bf9	\N
94dc4bce-4899-457e-b160-966ac65c566b	\N	idp-email-verification	1cc45988-1774-48f1-af0c-82610082f679	e54eee87-0d08-474e-97a2-1c9def432bf9	2	10	f	\N	\N
d9634eb5-79ca-45c3-8a30-1e9ff648c363	\N	\N	1cc45988-1774-48f1-af0c-82610082f679	e54eee87-0d08-474e-97a2-1c9def432bf9	2	20	t	2f0f8ead-d144-4dbc-88f4-041cb55b4f2b	\N
321d1122-f505-4179-818b-6aa7e03a45ba	\N	idp-username-password-form	1cc45988-1774-48f1-af0c-82610082f679	2f0f8ead-d144-4dbc-88f4-041cb55b4f2b	0	10	f	\N	\N
c033e6d5-1a9d-4922-93e8-564715c4b261	\N	\N	1cc45988-1774-48f1-af0c-82610082f679	2f0f8ead-d144-4dbc-88f4-041cb55b4f2b	1	20	t	44ee151c-7a8a-426e-ad1d-fa5a00a68a2a	\N
f2d0024f-4c94-490c-86d8-e6cedc597b91	\N	conditional-user-configured	1cc45988-1774-48f1-af0c-82610082f679	44ee151c-7a8a-426e-ad1d-fa5a00a68a2a	0	10	f	\N	\N
01948b34-871f-4606-8642-4b9165a894f4	\N	auth-otp-form	1cc45988-1774-48f1-af0c-82610082f679	44ee151c-7a8a-426e-ad1d-fa5a00a68a2a	0	20	f	\N	\N
0ef7458f-ff1c-4146-a558-c4a1c3ecd7a7	\N	http-basic-authenticator	1cc45988-1774-48f1-af0c-82610082f679	cc1bbbcb-2a91-4046-a674-790030302337	0	10	f	\N	\N
dc43e0e1-51ba-4ba0-b1e1-11cde041a77e	\N	docker-http-basic-authenticator	1cc45988-1774-48f1-af0c-82610082f679	139f0817-7246-42b7-97a6-2ca175fc3dc9	0	10	f	\N	\N
a1b5011b-1204-49d4-90b0-2f124cc8557c	\N	auth-cookie	fd31cefa-d2de-4b30-884e-96a0a709f62d	8e11de5f-187c-4fc2-9133-07fd25ca1310	2	10	f	\N	\N
86fefc89-ac53-46f9-bba7-d64323ed0f6f	\N	auth-spnego	fd31cefa-d2de-4b30-884e-96a0a709f62d	8e11de5f-187c-4fc2-9133-07fd25ca1310	3	20	f	\N	\N
0d7435a9-5812-4138-a2fa-2f3376671ddb	\N	identity-provider-redirector	fd31cefa-d2de-4b30-884e-96a0a709f62d	8e11de5f-187c-4fc2-9133-07fd25ca1310	2	25	f	\N	\N
efa62b57-7b91-4f44-b2dd-f0eb113ca298	\N	\N	fd31cefa-d2de-4b30-884e-96a0a709f62d	8e11de5f-187c-4fc2-9133-07fd25ca1310	2	30	t	341ad4e3-15d3-44d9-8705-31f700a0f95d	\N
6bdf8f28-ec48-47e9-8915-b5f1d35fcf5f	\N	auth-username-password-form	fd31cefa-d2de-4b30-884e-96a0a709f62d	341ad4e3-15d3-44d9-8705-31f700a0f95d	0	10	f	\N	\N
e6a7b75a-433b-4a6e-bdff-32af5cdab70e	\N	\N	fd31cefa-d2de-4b30-884e-96a0a709f62d	341ad4e3-15d3-44d9-8705-31f700a0f95d	1	20	t	888301e6-a11b-4503-8ad5-4c16df0a7878	\N
1253e2b0-30c8-4f48-a784-ed93ef00137f	\N	conditional-user-configured	fd31cefa-d2de-4b30-884e-96a0a709f62d	888301e6-a11b-4503-8ad5-4c16df0a7878	0	10	f	\N	\N
e5fbdd24-0b4e-4e9d-98a8-8a30dd15adb8	\N	auth-otp-form	fd31cefa-d2de-4b30-884e-96a0a709f62d	888301e6-a11b-4503-8ad5-4c16df0a7878	0	20	f	\N	\N
81380bda-c841-433c-ac3b-a83c36891c16	\N	direct-grant-validate-username	fd31cefa-d2de-4b30-884e-96a0a709f62d	5ca48a8b-b68f-497c-9064-315ab7154785	0	10	f	\N	\N
03c54599-df77-4c31-a6eb-5d66e70a891c	\N	direct-grant-validate-password	fd31cefa-d2de-4b30-884e-96a0a709f62d	5ca48a8b-b68f-497c-9064-315ab7154785	0	20	f	\N	\N
af2f187e-a30e-4301-8b84-b67459877d8f	\N	\N	fd31cefa-d2de-4b30-884e-96a0a709f62d	5ca48a8b-b68f-497c-9064-315ab7154785	1	30	t	859a96b5-29cf-4152-846b-110120520cd0	\N
96e19021-e709-45a1-8461-e57df2da36b4	\N	conditional-user-configured	fd31cefa-d2de-4b30-884e-96a0a709f62d	859a96b5-29cf-4152-846b-110120520cd0	0	10	f	\N	\N
8e7fe693-4983-4a31-bc94-ef78aef6bcb0	\N	direct-grant-validate-otp	fd31cefa-d2de-4b30-884e-96a0a709f62d	859a96b5-29cf-4152-846b-110120520cd0	0	20	f	\N	\N
57795ffd-8183-4ec0-96d9-7319c51076b0	\N	registration-page-form	fd31cefa-d2de-4b30-884e-96a0a709f62d	009bab91-b6ce-4533-a108-d3eb449174f7	0	10	t	8739824f-1dda-4129-8167-a3951c79851b	\N
25d043e6-0445-4e8a-8e5b-06f320787e53	\N	registration-user-creation	fd31cefa-d2de-4b30-884e-96a0a709f62d	8739824f-1dda-4129-8167-a3951c79851b	0	20	f	\N	\N
61b66b90-c100-4943-8084-c9afdfb2e240	\N	registration-profile-action	fd31cefa-d2de-4b30-884e-96a0a709f62d	8739824f-1dda-4129-8167-a3951c79851b	0	40	f	\N	\N
4264907d-73a3-4482-ac08-58924cbb8425	\N	registration-password-action	fd31cefa-d2de-4b30-884e-96a0a709f62d	8739824f-1dda-4129-8167-a3951c79851b	0	50	f	\N	\N
6f48ec1f-14ac-4490-a2ea-8e924fe8f951	\N	registration-recaptcha-action	fd31cefa-d2de-4b30-884e-96a0a709f62d	8739824f-1dda-4129-8167-a3951c79851b	3	60	f	\N	\N
65b18776-e850-47e1-9eb3-bd30400a6827	\N	reset-credentials-choose-user	fd31cefa-d2de-4b30-884e-96a0a709f62d	aa3a1651-4368-4df7-be32-49efee8e8ecf	0	10	f	\N	\N
1336822c-10d1-4a57-b50b-70742f7b5ded	\N	reset-credential-email	fd31cefa-d2de-4b30-884e-96a0a709f62d	aa3a1651-4368-4df7-be32-49efee8e8ecf	0	20	f	\N	\N
ec73aa83-f9d8-4990-916a-6359dc123bba	\N	reset-password	fd31cefa-d2de-4b30-884e-96a0a709f62d	aa3a1651-4368-4df7-be32-49efee8e8ecf	0	30	f	\N	\N
fa25731b-7f10-4014-a2bb-f21f0df031ef	\N	\N	fd31cefa-d2de-4b30-884e-96a0a709f62d	aa3a1651-4368-4df7-be32-49efee8e8ecf	1	40	t	e9ccd660-25ad-4443-9011-005bece4c5fa	\N
4a5f3496-be60-45bf-a053-90d939db0583	\N	conditional-user-configured	fd31cefa-d2de-4b30-884e-96a0a709f62d	e9ccd660-25ad-4443-9011-005bece4c5fa	0	10	f	\N	\N
d6de38fe-beac-4f1c-a174-7580e955c970	\N	reset-otp	fd31cefa-d2de-4b30-884e-96a0a709f62d	e9ccd660-25ad-4443-9011-005bece4c5fa	0	20	f	\N	\N
9684e1b0-f96d-4bb4-99db-6c84852bab32	\N	client-secret	fd31cefa-d2de-4b30-884e-96a0a709f62d	f73f9483-ffd5-4ca2-b53e-d94b4b8bd5c5	2	10	f	\N	\N
cc911206-2aeb-4039-832d-8fa7001c8bd2	\N	client-jwt	fd31cefa-d2de-4b30-884e-96a0a709f62d	f73f9483-ffd5-4ca2-b53e-d94b4b8bd5c5	2	20	f	\N	\N
fe99f548-ba53-4a82-a679-21397110ccd5	\N	client-secret-jwt	fd31cefa-d2de-4b30-884e-96a0a709f62d	f73f9483-ffd5-4ca2-b53e-d94b4b8bd5c5	2	30	f	\N	\N
88b56bc3-e9a8-47dc-9c70-7bc73ba1eff5	\N	client-x509	fd31cefa-d2de-4b30-884e-96a0a709f62d	f73f9483-ffd5-4ca2-b53e-d94b4b8bd5c5	2	40	f	\N	\N
1199bf24-1c5b-4c0c-b14e-f0c374d4ca62	\N	idp-review-profile	fd31cefa-d2de-4b30-884e-96a0a709f62d	36b69a9a-5cdc-4093-b5a5-2a8d1fd219ca	0	10	f	\N	7e2dd90b-e1d2-4f7e-b0dc-86803743a967
e66bd2df-1531-42fe-ab38-89fc1b6e5656	\N	\N	fd31cefa-d2de-4b30-884e-96a0a709f62d	36b69a9a-5cdc-4093-b5a5-2a8d1fd219ca	0	20	t	9dfa28d3-118a-4c37-8596-7608ab0bf817	\N
f52d6595-fb7e-47c2-84c7-675c7d42853b	\N	idp-create-user-if-unique	fd31cefa-d2de-4b30-884e-96a0a709f62d	9dfa28d3-118a-4c37-8596-7608ab0bf817	2	10	f	\N	787d0df8-dcad-4097-9e14-af0c104c3d20
ba1b8dbf-a28f-4db9-a581-27d9cacccee1	\N	\N	fd31cefa-d2de-4b30-884e-96a0a709f62d	9dfa28d3-118a-4c37-8596-7608ab0bf817	2	20	t	3c7a865d-18dc-41d0-aa34-5cf561b627b0	\N
e487db96-daeb-4a03-ad07-b472fc4e714b	\N	idp-confirm-link	fd31cefa-d2de-4b30-884e-96a0a709f62d	3c7a865d-18dc-41d0-aa34-5cf561b627b0	0	10	f	\N	\N
b7f3265c-c2bf-4fc2-9d9f-1112feb46ad3	\N	\N	fd31cefa-d2de-4b30-884e-96a0a709f62d	3c7a865d-18dc-41d0-aa34-5cf561b627b0	0	20	t	8c46ab23-5de3-4d25-9d34-bf72c593b2de	\N
aa513e4e-f13b-4b85-be54-bf84d4557ecb	\N	idp-email-verification	fd31cefa-d2de-4b30-884e-96a0a709f62d	8c46ab23-5de3-4d25-9d34-bf72c593b2de	2	10	f	\N	\N
8741c808-6c7f-40a8-a459-ddf949f4a1b7	\N	\N	fd31cefa-d2de-4b30-884e-96a0a709f62d	8c46ab23-5de3-4d25-9d34-bf72c593b2de	2	20	t	359dfa1d-8eb8-43c1-8745-e902ea0922d4	\N
28a47666-a367-4be0-80eb-3e0a063e564d	\N	idp-username-password-form	fd31cefa-d2de-4b30-884e-96a0a709f62d	359dfa1d-8eb8-43c1-8745-e902ea0922d4	0	10	f	\N	\N
a4e96cd2-307a-48dd-975d-38d09ceedafd	\N	\N	fd31cefa-d2de-4b30-884e-96a0a709f62d	359dfa1d-8eb8-43c1-8745-e902ea0922d4	1	20	t	3e4280a1-9bcd-4b7d-8495-fcbe0ef50186	\N
5111fd11-5ab4-458c-968c-627d0e51c154	\N	conditional-user-configured	fd31cefa-d2de-4b30-884e-96a0a709f62d	3e4280a1-9bcd-4b7d-8495-fcbe0ef50186	0	10	f	\N	\N
0053dc0b-4c25-4dd3-8b54-5337ee3a129f	\N	auth-otp-form	fd31cefa-d2de-4b30-884e-96a0a709f62d	3e4280a1-9bcd-4b7d-8495-fcbe0ef50186	0	20	f	\N	\N
1ef2f643-8c0b-4a45-adde-07d9cc272548	\N	http-basic-authenticator	fd31cefa-d2de-4b30-884e-96a0a709f62d	ae61fafa-a1dc-431a-b47d-995ac8d126b3	0	10	f	\N	\N
cbe61d8e-9d49-4afe-bed4-594f70935500	\N	docker-http-basic-authenticator	fd31cefa-d2de-4b30-884e-96a0a709f62d	89fee860-6f1c-4880-9108-7290940b40e1	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
b55a7f53-fa7b-4cbb-b05f-a35611337974	browser	browser based authentication	1cc45988-1774-48f1-af0c-82610082f679	basic-flow	t	t
bbd006b5-9e83-4f08-a0fe-0d38d081ab36	forms	Username, password, otp and other auth forms.	1cc45988-1774-48f1-af0c-82610082f679	basic-flow	f	t
c29b1031-7415-4adb-8ee5-51f158874559	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	1cc45988-1774-48f1-af0c-82610082f679	basic-flow	f	t
ffca43b4-d63d-4533-b30c-2a837f9c6b94	direct grant	OpenID Connect Resource Owner Grant	1cc45988-1774-48f1-af0c-82610082f679	basic-flow	t	t
86268ffe-fd5d-4068-9ded-316ea986ece4	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	1cc45988-1774-48f1-af0c-82610082f679	basic-flow	f	t
d941d676-22db-4ff8-a265-518a4462c2b6	registration	registration flow	1cc45988-1774-48f1-af0c-82610082f679	basic-flow	t	t
82867a26-a879-4671-a08e-ea9ea6014f05	registration form	registration form	1cc45988-1774-48f1-af0c-82610082f679	form-flow	f	t
c2f76612-011e-497c-888c-d00c280ffba5	reset credentials	Reset credentials for a user if they forgot their password or something	1cc45988-1774-48f1-af0c-82610082f679	basic-flow	t	t
52a32fd1-803f-4812-8c73-d6df98aaf3c5	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	1cc45988-1774-48f1-af0c-82610082f679	basic-flow	f	t
ee300e14-5742-43c5-ab90-83014c3510a6	clients	Base authentication for clients	1cc45988-1774-48f1-af0c-82610082f679	client-flow	t	t
edb995df-d59c-4ea2-b548-a664f044985e	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	1cc45988-1774-48f1-af0c-82610082f679	basic-flow	t	t
342efa59-e33e-4e32-9bdf-31a3eae92a57	User creation or linking	Flow for the existing/non-existing user alternatives	1cc45988-1774-48f1-af0c-82610082f679	basic-flow	f	t
57e1bbc2-b334-4f1e-915d-81c75221d1e2	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	1cc45988-1774-48f1-af0c-82610082f679	basic-flow	f	t
e54eee87-0d08-474e-97a2-1c9def432bf9	Account verification options	Method with which to verity the existing account	1cc45988-1774-48f1-af0c-82610082f679	basic-flow	f	t
2f0f8ead-d144-4dbc-88f4-041cb55b4f2b	Verify Existing Account by Re-authentication	Reauthentication of existing account	1cc45988-1774-48f1-af0c-82610082f679	basic-flow	f	t
44ee151c-7a8a-426e-ad1d-fa5a00a68a2a	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	1cc45988-1774-48f1-af0c-82610082f679	basic-flow	f	t
cc1bbbcb-2a91-4046-a674-790030302337	saml ecp	SAML ECP Profile Authentication Flow	1cc45988-1774-48f1-af0c-82610082f679	basic-flow	t	t
139f0817-7246-42b7-97a6-2ca175fc3dc9	docker auth	Used by Docker clients to authenticate against the IDP	1cc45988-1774-48f1-af0c-82610082f679	basic-flow	t	t
8e11de5f-187c-4fc2-9133-07fd25ca1310	browser	browser based authentication	fd31cefa-d2de-4b30-884e-96a0a709f62d	basic-flow	t	t
341ad4e3-15d3-44d9-8705-31f700a0f95d	forms	Username, password, otp and other auth forms.	fd31cefa-d2de-4b30-884e-96a0a709f62d	basic-flow	f	t
888301e6-a11b-4503-8ad5-4c16df0a7878	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	fd31cefa-d2de-4b30-884e-96a0a709f62d	basic-flow	f	t
5ca48a8b-b68f-497c-9064-315ab7154785	direct grant	OpenID Connect Resource Owner Grant	fd31cefa-d2de-4b30-884e-96a0a709f62d	basic-flow	t	t
859a96b5-29cf-4152-846b-110120520cd0	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	fd31cefa-d2de-4b30-884e-96a0a709f62d	basic-flow	f	t
009bab91-b6ce-4533-a108-d3eb449174f7	registration	registration flow	fd31cefa-d2de-4b30-884e-96a0a709f62d	basic-flow	t	t
8739824f-1dda-4129-8167-a3951c79851b	registration form	registration form	fd31cefa-d2de-4b30-884e-96a0a709f62d	form-flow	f	t
aa3a1651-4368-4df7-be32-49efee8e8ecf	reset credentials	Reset credentials for a user if they forgot their password or something	fd31cefa-d2de-4b30-884e-96a0a709f62d	basic-flow	t	t
e9ccd660-25ad-4443-9011-005bece4c5fa	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	fd31cefa-d2de-4b30-884e-96a0a709f62d	basic-flow	f	t
f73f9483-ffd5-4ca2-b53e-d94b4b8bd5c5	clients	Base authentication for clients	fd31cefa-d2de-4b30-884e-96a0a709f62d	client-flow	t	t
36b69a9a-5cdc-4093-b5a5-2a8d1fd219ca	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	fd31cefa-d2de-4b30-884e-96a0a709f62d	basic-flow	t	t
9dfa28d3-118a-4c37-8596-7608ab0bf817	User creation or linking	Flow for the existing/non-existing user alternatives	fd31cefa-d2de-4b30-884e-96a0a709f62d	basic-flow	f	t
3c7a865d-18dc-41d0-aa34-5cf561b627b0	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	fd31cefa-d2de-4b30-884e-96a0a709f62d	basic-flow	f	t
8c46ab23-5de3-4d25-9d34-bf72c593b2de	Account verification options	Method with which to verity the existing account	fd31cefa-d2de-4b30-884e-96a0a709f62d	basic-flow	f	t
359dfa1d-8eb8-43c1-8745-e902ea0922d4	Verify Existing Account by Re-authentication	Reauthentication of existing account	fd31cefa-d2de-4b30-884e-96a0a709f62d	basic-flow	f	t
3e4280a1-9bcd-4b7d-8495-fcbe0ef50186	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	fd31cefa-d2de-4b30-884e-96a0a709f62d	basic-flow	f	t
ae61fafa-a1dc-431a-b47d-995ac8d126b3	saml ecp	SAML ECP Profile Authentication Flow	fd31cefa-d2de-4b30-884e-96a0a709f62d	basic-flow	t	t
89fee860-6f1c-4880-9108-7290940b40e1	docker auth	Used by Docker clients to authenticate against the IDP	fd31cefa-d2de-4b30-884e-96a0a709f62d	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
be1db97e-6976-43c5-83b0-3272d34fee20	review profile config	1cc45988-1774-48f1-af0c-82610082f679
0cc83cdf-6903-46b6-ba89-5245063b1dc7	create unique user config	1cc45988-1774-48f1-af0c-82610082f679
7e2dd90b-e1d2-4f7e-b0dc-86803743a967	review profile config	fd31cefa-d2de-4b30-884e-96a0a709f62d
787d0df8-dcad-4097-9e14-af0c104c3d20	create unique user config	fd31cefa-d2de-4b30-884e-96a0a709f62d
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
0cc83cdf-6903-46b6-ba89-5245063b1dc7	false	require.password.update.after.registration
be1db97e-6976-43c5-83b0-3272d34fee20	missing	update.profile.on.first.login
787d0df8-dcad-4097-9e14-af0c104c3d20	false	require.password.update.after.registration
7e2dd90b-e1d2-4f7e-b0dc-86803743a967	missing	update.profile.on.first.login
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
461713e1-3a6d-44d1-af1f-051eae64b3a1	t	f	master-realm	0	f	\N	\N	t	\N	f	1cc45988-1774-48f1-af0c-82610082f679	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
973ab1c7-211d-4310-8bc8-f2a30f74d7a6	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	1cc45988-1774-48f1-af0c-82610082f679	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
d6e31b97-3056-4faf-9919-93710213550f	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	1cc45988-1774-48f1-af0c-82610082f679	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
6e06434d-8058-4631-b93f-d97693c4527e	t	f	broker	0	f	\N	\N	t	\N	f	1cc45988-1774-48f1-af0c-82610082f679	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
93129fbc-1e55-4d70-9c6c-a2e09e74066f	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	1cc45988-1774-48f1-af0c-82610082f679	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
84f88319-ae5f-43af-8082-b672daef927d	t	f	maps-eh-realm	0	f	\N	\N	t	\N	f	1cc45988-1774-48f1-af0c-82610082f679	\N	0	f	f	maps-eh Realm	f	client-secret	\N	\N	\N	t	f	f	f
7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	t	f	realm-management	0	f	\N	\N	t	\N	f	fd31cefa-d2de-4b30-884e-96a0a709f62d	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
55f49bf2-eaeb-4533-975d-9a07d5d20835	t	f	account	0	t	\N	/realms/maps-eh/account/	f	\N	f	fd31cefa-d2de-4b30-884e-96a0a709f62d	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
a3282fc4-8a2a-45da-a49f-7bfa42d3a853	t	f	account-console	0	t	\N	/realms/maps-eh/account/	f	\N	f	fd31cefa-d2de-4b30-884e-96a0a709f62d	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
f1a52f57-a2b2-48cf-a798-f4855efd1bbc	t	f	broker	0	f	\N	\N	t	\N	f	fd31cefa-d2de-4b30-884e-96a0a709f62d	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
a6b150e6-04e7-4502-b55c-35a8d1b66eb0	t	f	security-admin-console	0	t	\N	/admin/maps-eh/console/	f	\N	f	fd31cefa-d2de-4b30-884e-96a0a709f62d	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
9d270c10-830e-45fa-ac7d-f919ab5b73cd	t	t	test-client	0	f	JNKseQQjG7Kg7Va0rWp3v5bCpgyfrWYy		f	http://localhost:8080/test	f	fd31cefa-d2de-4b30-884e-96a0a709f62d	openid-connect	-1	t	f	Test	t	client-secret	http://localhost:8080/test		\N	t	f	t	f
a54d40d9-eed6-4b4f-bc19-4b3c57f666b9	t	f	admin-cli	0	f	ln8iMZ2qlVjk2sxOpA5mkcT6q9iV6OwB		f		f	1cc45988-1774-48f1-af0c-82610082f679	openid-connect	0	f	f	${client_admin-cli}	t	client-secret			\N	t	f	t	f
47820472-954a-4742-9cb3-cf82d38e5190	t	t	mapseh-client	0	f	U9RBZPd1VSHAhJYAGmmLxyqjhBVosGEi		f		f	fd31cefa-d2de-4b30-884e-96a0a709f62d	openid-connect	-1	t	f		t	client-secret	http://localhost:8080/maps-eh		\N	t	f	t	f
7515e33c-65b7-4518-ad98-3711bbbc8f9c	t	f	admin-cli	0	t	\N		f		f	fd31cefa-d2de-4b30-884e-96a0a709f62d	openid-connect	0	f	f	${client_admin-cli}	f	client-secret			\N	t	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
973ab1c7-211d-4310-8bc8-f2a30f74d7a6	post.logout.redirect.uris	+
d6e31b97-3056-4faf-9919-93710213550f	post.logout.redirect.uris	+
d6e31b97-3056-4faf-9919-93710213550f	pkce.code.challenge.method	S256
93129fbc-1e55-4d70-9c6c-a2e09e74066f	post.logout.redirect.uris	+
93129fbc-1e55-4d70-9c6c-a2e09e74066f	pkce.code.challenge.method	S256
55f49bf2-eaeb-4533-975d-9a07d5d20835	post.logout.redirect.uris	+
a3282fc4-8a2a-45da-a49f-7bfa42d3a853	post.logout.redirect.uris	+
a3282fc4-8a2a-45da-a49f-7bfa42d3a853	pkce.code.challenge.method	S256
a6b150e6-04e7-4502-b55c-35a8d1b66eb0	post.logout.redirect.uris	+
a6b150e6-04e7-4502-b55c-35a8d1b66eb0	pkce.code.challenge.method	S256
47820472-954a-4742-9cb3-cf82d38e5190	client.secret.creation.time	1689259064
47820472-954a-4742-9cb3-cf82d38e5190	oauth2.device.authorization.grant.enabled	false
47820472-954a-4742-9cb3-cf82d38e5190	oidc.ciba.grant.enabled	false
47820472-954a-4742-9cb3-cf82d38e5190	post.logout.redirect.uris	http://localhost:3000/*##https://micare.whattadata.it/*
47820472-954a-4742-9cb3-cf82d38e5190	backchannel.logout.session.required	true
47820472-954a-4742-9cb3-cf82d38e5190	backchannel.logout.revoke.offline.tokens	false
47820472-954a-4742-9cb3-cf82d38e5190	display.on.consent.screen	false
9d270c10-830e-45fa-ac7d-f919ab5b73cd	client.secret.creation.time	1694017589
9d270c10-830e-45fa-ac7d-f919ab5b73cd	oauth2.device.authorization.grant.enabled	false
9d270c10-830e-45fa-ac7d-f919ab5b73cd	oidc.ciba.grant.enabled	false
9d270c10-830e-45fa-ac7d-f919ab5b73cd	backchannel.logout.session.required	true
9d270c10-830e-45fa-ac7d-f919ab5b73cd	backchannel.logout.revoke.offline.tokens	false
a54d40d9-eed6-4b4f-bc19-4b3c57f666b9	client.secret.creation.time	1694018538
7515e33c-65b7-4518-ad98-3711bbbc8f9c	backchannel.logout.url	http://localhost/auth/realms/mapseh-client/protocol/openid-connect/logout
7515e33c-65b7-4518-ad98-3711bbbc8f9c	client.secret.creation.time	1695059168
7515e33c-65b7-4518-ad98-3711bbbc8f9c	oauth2.device.authorization.grant.enabled	false
7515e33c-65b7-4518-ad98-3711bbbc8f9c	oidc.ciba.grant.enabled	false
7515e33c-65b7-4518-ad98-3711bbbc8f9c	display.on.consent.screen	false
7515e33c-65b7-4518-ad98-3711bbbc8f9c	backchannel.logout.session.required	true
7515e33c-65b7-4518-ad98-3711bbbc8f9c	backchannel.logout.revoke.offline.tokens	false
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
abffa3df-9848-42b2-9cd8-b794d6276323	offline_access	1cc45988-1774-48f1-af0c-82610082f679	OpenID Connect built-in scope: offline_access	openid-connect
92aa7bbc-57ee-4818-b099-31978b50fcb4	role_list	1cc45988-1774-48f1-af0c-82610082f679	SAML role list	saml
1bf4f16b-ac24-4b8b-b37c-c3d1e8ea04dc	profile	1cc45988-1774-48f1-af0c-82610082f679	OpenID Connect built-in scope: profile	openid-connect
c004f83e-0447-4b54-9a8e-86ce5bf31659	email	1cc45988-1774-48f1-af0c-82610082f679	OpenID Connect built-in scope: email	openid-connect
6b166822-e30d-43f0-9b3f-3f9fe2e4b85d	address	1cc45988-1774-48f1-af0c-82610082f679	OpenID Connect built-in scope: address	openid-connect
0d45615a-7d8a-4f38-9732-ac2ad00c4bd4	phone	1cc45988-1774-48f1-af0c-82610082f679	OpenID Connect built-in scope: phone	openid-connect
730703e7-778f-413b-a5fb-c827bd1e40c6	roles	1cc45988-1774-48f1-af0c-82610082f679	OpenID Connect scope for add user roles to the access token	openid-connect
1a2033a7-da9c-4d84-b400-76335ece1b7d	web-origins	1cc45988-1774-48f1-af0c-82610082f679	OpenID Connect scope for add allowed web origins to the access token	openid-connect
1e10e8f1-decd-4acf-90e9-b02ba945c11c	microprofile-jwt	1cc45988-1774-48f1-af0c-82610082f679	Microprofile - JWT built-in scope	openid-connect
622124d9-c441-4690-8c25-7e621871e502	acr	1cc45988-1774-48f1-af0c-82610082f679	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
71cc9248-d579-4c0e-8663-a2656961ae1f	offline_access	fd31cefa-d2de-4b30-884e-96a0a709f62d	OpenID Connect built-in scope: offline_access	openid-connect
16bb13ec-6d58-4ffa-8c7a-ac245578dfaf	role_list	fd31cefa-d2de-4b30-884e-96a0a709f62d	SAML role list	saml
7fa04efb-e52a-40d9-9c91-5caee279c390	profile	fd31cefa-d2de-4b30-884e-96a0a709f62d	OpenID Connect built-in scope: profile	openid-connect
53305b8b-f82e-4974-a0c8-0c119305275d	email	fd31cefa-d2de-4b30-884e-96a0a709f62d	OpenID Connect built-in scope: email	openid-connect
832ed194-774b-46c3-8ef7-27abb084324d	address	fd31cefa-d2de-4b30-884e-96a0a709f62d	OpenID Connect built-in scope: address	openid-connect
4bdf1d1a-8eb1-491d-b08d-3f86451861d2	phone	fd31cefa-d2de-4b30-884e-96a0a709f62d	OpenID Connect built-in scope: phone	openid-connect
e398020c-1ec1-487e-9584-34a75459de0e	roles	fd31cefa-d2de-4b30-884e-96a0a709f62d	OpenID Connect scope for add user roles to the access token	openid-connect
4b0e37e8-57e4-4bb8-8634-f49ff60e1cbc	web-origins	fd31cefa-d2de-4b30-884e-96a0a709f62d	OpenID Connect scope for add allowed web origins to the access token	openid-connect
689569d2-a88d-42c9-910a-b6d626dddf6e	microprofile-jwt	fd31cefa-d2de-4b30-884e-96a0a709f62d	Microprofile - JWT built-in scope	openid-connect
76459466-f04e-48c4-9264-e85d88f829f1	acr	fd31cefa-d2de-4b30-884e-96a0a709f62d	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
1ab56eb4-8970-4b91-8807-45ee7e579c6f	group	fd31cefa-d2de-4b30-884e-96a0a709f62d	group	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
abffa3df-9848-42b2-9cd8-b794d6276323	true	display.on.consent.screen
abffa3df-9848-42b2-9cd8-b794d6276323	${offlineAccessScopeConsentText}	consent.screen.text
92aa7bbc-57ee-4818-b099-31978b50fcb4	true	display.on.consent.screen
92aa7bbc-57ee-4818-b099-31978b50fcb4	${samlRoleListScopeConsentText}	consent.screen.text
1bf4f16b-ac24-4b8b-b37c-c3d1e8ea04dc	true	display.on.consent.screen
1bf4f16b-ac24-4b8b-b37c-c3d1e8ea04dc	${profileScopeConsentText}	consent.screen.text
1bf4f16b-ac24-4b8b-b37c-c3d1e8ea04dc	true	include.in.token.scope
c004f83e-0447-4b54-9a8e-86ce5bf31659	true	display.on.consent.screen
c004f83e-0447-4b54-9a8e-86ce5bf31659	${emailScopeConsentText}	consent.screen.text
c004f83e-0447-4b54-9a8e-86ce5bf31659	true	include.in.token.scope
6b166822-e30d-43f0-9b3f-3f9fe2e4b85d	true	display.on.consent.screen
6b166822-e30d-43f0-9b3f-3f9fe2e4b85d	${addressScopeConsentText}	consent.screen.text
6b166822-e30d-43f0-9b3f-3f9fe2e4b85d	true	include.in.token.scope
0d45615a-7d8a-4f38-9732-ac2ad00c4bd4	true	display.on.consent.screen
0d45615a-7d8a-4f38-9732-ac2ad00c4bd4	${phoneScopeConsentText}	consent.screen.text
0d45615a-7d8a-4f38-9732-ac2ad00c4bd4	true	include.in.token.scope
730703e7-778f-413b-a5fb-c827bd1e40c6	true	display.on.consent.screen
730703e7-778f-413b-a5fb-c827bd1e40c6	${rolesScopeConsentText}	consent.screen.text
730703e7-778f-413b-a5fb-c827bd1e40c6	false	include.in.token.scope
1a2033a7-da9c-4d84-b400-76335ece1b7d	false	display.on.consent.screen
1a2033a7-da9c-4d84-b400-76335ece1b7d		consent.screen.text
1a2033a7-da9c-4d84-b400-76335ece1b7d	false	include.in.token.scope
1e10e8f1-decd-4acf-90e9-b02ba945c11c	false	display.on.consent.screen
1e10e8f1-decd-4acf-90e9-b02ba945c11c	true	include.in.token.scope
622124d9-c441-4690-8c25-7e621871e502	false	display.on.consent.screen
622124d9-c441-4690-8c25-7e621871e502	false	include.in.token.scope
71cc9248-d579-4c0e-8663-a2656961ae1f	true	display.on.consent.screen
71cc9248-d579-4c0e-8663-a2656961ae1f	${offlineAccessScopeConsentText}	consent.screen.text
16bb13ec-6d58-4ffa-8c7a-ac245578dfaf	true	display.on.consent.screen
16bb13ec-6d58-4ffa-8c7a-ac245578dfaf	${samlRoleListScopeConsentText}	consent.screen.text
7fa04efb-e52a-40d9-9c91-5caee279c390	true	display.on.consent.screen
7fa04efb-e52a-40d9-9c91-5caee279c390	${profileScopeConsentText}	consent.screen.text
7fa04efb-e52a-40d9-9c91-5caee279c390	true	include.in.token.scope
53305b8b-f82e-4974-a0c8-0c119305275d	true	display.on.consent.screen
53305b8b-f82e-4974-a0c8-0c119305275d	${emailScopeConsentText}	consent.screen.text
53305b8b-f82e-4974-a0c8-0c119305275d	true	include.in.token.scope
832ed194-774b-46c3-8ef7-27abb084324d	true	display.on.consent.screen
832ed194-774b-46c3-8ef7-27abb084324d	${addressScopeConsentText}	consent.screen.text
832ed194-774b-46c3-8ef7-27abb084324d	true	include.in.token.scope
4bdf1d1a-8eb1-491d-b08d-3f86451861d2	true	display.on.consent.screen
4bdf1d1a-8eb1-491d-b08d-3f86451861d2	${phoneScopeConsentText}	consent.screen.text
4bdf1d1a-8eb1-491d-b08d-3f86451861d2	true	include.in.token.scope
e398020c-1ec1-487e-9584-34a75459de0e	true	display.on.consent.screen
e398020c-1ec1-487e-9584-34a75459de0e	${rolesScopeConsentText}	consent.screen.text
4b0e37e8-57e4-4bb8-8634-f49ff60e1cbc	false	display.on.consent.screen
4b0e37e8-57e4-4bb8-8634-f49ff60e1cbc		consent.screen.text
4b0e37e8-57e4-4bb8-8634-f49ff60e1cbc	false	include.in.token.scope
689569d2-a88d-42c9-910a-b6d626dddf6e	false	display.on.consent.screen
689569d2-a88d-42c9-910a-b6d626dddf6e	true	include.in.token.scope
76459466-f04e-48c4-9264-e85d88f829f1	false	display.on.consent.screen
76459466-f04e-48c4-9264-e85d88f829f1	false	include.in.token.scope
e398020c-1ec1-487e-9584-34a75459de0e		gui.order
e398020c-1ec1-487e-9584-34a75459de0e	true	include.in.token.scope
1ab56eb4-8970-4b91-8807-45ee7e579c6f		consent.screen.text
1ab56eb4-8970-4b91-8807-45ee7e579c6f	true	display.on.consent.screen
1ab56eb4-8970-4b91-8807-45ee7e579c6f	true	include.in.token.scope
1ab56eb4-8970-4b91-8807-45ee7e579c6f		gui.order
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
973ab1c7-211d-4310-8bc8-f2a30f74d7a6	622124d9-c441-4690-8c25-7e621871e502	t
973ab1c7-211d-4310-8bc8-f2a30f74d7a6	1bf4f16b-ac24-4b8b-b37c-c3d1e8ea04dc	t
973ab1c7-211d-4310-8bc8-f2a30f74d7a6	c004f83e-0447-4b54-9a8e-86ce5bf31659	t
973ab1c7-211d-4310-8bc8-f2a30f74d7a6	730703e7-778f-413b-a5fb-c827bd1e40c6	t
973ab1c7-211d-4310-8bc8-f2a30f74d7a6	1a2033a7-da9c-4d84-b400-76335ece1b7d	t
973ab1c7-211d-4310-8bc8-f2a30f74d7a6	0d45615a-7d8a-4f38-9732-ac2ad00c4bd4	f
973ab1c7-211d-4310-8bc8-f2a30f74d7a6	abffa3df-9848-42b2-9cd8-b794d6276323	f
973ab1c7-211d-4310-8bc8-f2a30f74d7a6	6b166822-e30d-43f0-9b3f-3f9fe2e4b85d	f
973ab1c7-211d-4310-8bc8-f2a30f74d7a6	1e10e8f1-decd-4acf-90e9-b02ba945c11c	f
d6e31b97-3056-4faf-9919-93710213550f	622124d9-c441-4690-8c25-7e621871e502	t
d6e31b97-3056-4faf-9919-93710213550f	1bf4f16b-ac24-4b8b-b37c-c3d1e8ea04dc	t
d6e31b97-3056-4faf-9919-93710213550f	c004f83e-0447-4b54-9a8e-86ce5bf31659	t
d6e31b97-3056-4faf-9919-93710213550f	730703e7-778f-413b-a5fb-c827bd1e40c6	t
d6e31b97-3056-4faf-9919-93710213550f	1a2033a7-da9c-4d84-b400-76335ece1b7d	t
d6e31b97-3056-4faf-9919-93710213550f	0d45615a-7d8a-4f38-9732-ac2ad00c4bd4	f
d6e31b97-3056-4faf-9919-93710213550f	abffa3df-9848-42b2-9cd8-b794d6276323	f
d6e31b97-3056-4faf-9919-93710213550f	6b166822-e30d-43f0-9b3f-3f9fe2e4b85d	f
d6e31b97-3056-4faf-9919-93710213550f	1e10e8f1-decd-4acf-90e9-b02ba945c11c	f
a54d40d9-eed6-4b4f-bc19-4b3c57f666b9	622124d9-c441-4690-8c25-7e621871e502	t
a54d40d9-eed6-4b4f-bc19-4b3c57f666b9	1bf4f16b-ac24-4b8b-b37c-c3d1e8ea04dc	t
a54d40d9-eed6-4b4f-bc19-4b3c57f666b9	c004f83e-0447-4b54-9a8e-86ce5bf31659	t
a54d40d9-eed6-4b4f-bc19-4b3c57f666b9	730703e7-778f-413b-a5fb-c827bd1e40c6	t
a54d40d9-eed6-4b4f-bc19-4b3c57f666b9	1a2033a7-da9c-4d84-b400-76335ece1b7d	t
a54d40d9-eed6-4b4f-bc19-4b3c57f666b9	0d45615a-7d8a-4f38-9732-ac2ad00c4bd4	f
a54d40d9-eed6-4b4f-bc19-4b3c57f666b9	abffa3df-9848-42b2-9cd8-b794d6276323	f
a54d40d9-eed6-4b4f-bc19-4b3c57f666b9	6b166822-e30d-43f0-9b3f-3f9fe2e4b85d	f
a54d40d9-eed6-4b4f-bc19-4b3c57f666b9	1e10e8f1-decd-4acf-90e9-b02ba945c11c	f
6e06434d-8058-4631-b93f-d97693c4527e	622124d9-c441-4690-8c25-7e621871e502	t
6e06434d-8058-4631-b93f-d97693c4527e	1bf4f16b-ac24-4b8b-b37c-c3d1e8ea04dc	t
6e06434d-8058-4631-b93f-d97693c4527e	c004f83e-0447-4b54-9a8e-86ce5bf31659	t
6e06434d-8058-4631-b93f-d97693c4527e	730703e7-778f-413b-a5fb-c827bd1e40c6	t
6e06434d-8058-4631-b93f-d97693c4527e	1a2033a7-da9c-4d84-b400-76335ece1b7d	t
6e06434d-8058-4631-b93f-d97693c4527e	0d45615a-7d8a-4f38-9732-ac2ad00c4bd4	f
6e06434d-8058-4631-b93f-d97693c4527e	abffa3df-9848-42b2-9cd8-b794d6276323	f
6e06434d-8058-4631-b93f-d97693c4527e	6b166822-e30d-43f0-9b3f-3f9fe2e4b85d	f
6e06434d-8058-4631-b93f-d97693c4527e	1e10e8f1-decd-4acf-90e9-b02ba945c11c	f
461713e1-3a6d-44d1-af1f-051eae64b3a1	622124d9-c441-4690-8c25-7e621871e502	t
461713e1-3a6d-44d1-af1f-051eae64b3a1	1bf4f16b-ac24-4b8b-b37c-c3d1e8ea04dc	t
461713e1-3a6d-44d1-af1f-051eae64b3a1	c004f83e-0447-4b54-9a8e-86ce5bf31659	t
461713e1-3a6d-44d1-af1f-051eae64b3a1	730703e7-778f-413b-a5fb-c827bd1e40c6	t
461713e1-3a6d-44d1-af1f-051eae64b3a1	1a2033a7-da9c-4d84-b400-76335ece1b7d	t
461713e1-3a6d-44d1-af1f-051eae64b3a1	0d45615a-7d8a-4f38-9732-ac2ad00c4bd4	f
461713e1-3a6d-44d1-af1f-051eae64b3a1	abffa3df-9848-42b2-9cd8-b794d6276323	f
461713e1-3a6d-44d1-af1f-051eae64b3a1	6b166822-e30d-43f0-9b3f-3f9fe2e4b85d	f
461713e1-3a6d-44d1-af1f-051eae64b3a1	1e10e8f1-decd-4acf-90e9-b02ba945c11c	f
93129fbc-1e55-4d70-9c6c-a2e09e74066f	622124d9-c441-4690-8c25-7e621871e502	t
93129fbc-1e55-4d70-9c6c-a2e09e74066f	1bf4f16b-ac24-4b8b-b37c-c3d1e8ea04dc	t
93129fbc-1e55-4d70-9c6c-a2e09e74066f	c004f83e-0447-4b54-9a8e-86ce5bf31659	t
93129fbc-1e55-4d70-9c6c-a2e09e74066f	730703e7-778f-413b-a5fb-c827bd1e40c6	t
93129fbc-1e55-4d70-9c6c-a2e09e74066f	1a2033a7-da9c-4d84-b400-76335ece1b7d	t
93129fbc-1e55-4d70-9c6c-a2e09e74066f	0d45615a-7d8a-4f38-9732-ac2ad00c4bd4	f
93129fbc-1e55-4d70-9c6c-a2e09e74066f	abffa3df-9848-42b2-9cd8-b794d6276323	f
93129fbc-1e55-4d70-9c6c-a2e09e74066f	6b166822-e30d-43f0-9b3f-3f9fe2e4b85d	f
93129fbc-1e55-4d70-9c6c-a2e09e74066f	1e10e8f1-decd-4acf-90e9-b02ba945c11c	f
55f49bf2-eaeb-4533-975d-9a07d5d20835	e398020c-1ec1-487e-9584-34a75459de0e	t
55f49bf2-eaeb-4533-975d-9a07d5d20835	7fa04efb-e52a-40d9-9c91-5caee279c390	t
55f49bf2-eaeb-4533-975d-9a07d5d20835	76459466-f04e-48c4-9264-e85d88f829f1	t
55f49bf2-eaeb-4533-975d-9a07d5d20835	53305b8b-f82e-4974-a0c8-0c119305275d	t
55f49bf2-eaeb-4533-975d-9a07d5d20835	4b0e37e8-57e4-4bb8-8634-f49ff60e1cbc	t
55f49bf2-eaeb-4533-975d-9a07d5d20835	832ed194-774b-46c3-8ef7-27abb084324d	f
55f49bf2-eaeb-4533-975d-9a07d5d20835	689569d2-a88d-42c9-910a-b6d626dddf6e	f
55f49bf2-eaeb-4533-975d-9a07d5d20835	71cc9248-d579-4c0e-8663-a2656961ae1f	f
55f49bf2-eaeb-4533-975d-9a07d5d20835	4bdf1d1a-8eb1-491d-b08d-3f86451861d2	f
a3282fc4-8a2a-45da-a49f-7bfa42d3a853	e398020c-1ec1-487e-9584-34a75459de0e	t
a3282fc4-8a2a-45da-a49f-7bfa42d3a853	7fa04efb-e52a-40d9-9c91-5caee279c390	t
a3282fc4-8a2a-45da-a49f-7bfa42d3a853	76459466-f04e-48c4-9264-e85d88f829f1	t
a3282fc4-8a2a-45da-a49f-7bfa42d3a853	53305b8b-f82e-4974-a0c8-0c119305275d	t
a3282fc4-8a2a-45da-a49f-7bfa42d3a853	4b0e37e8-57e4-4bb8-8634-f49ff60e1cbc	t
a3282fc4-8a2a-45da-a49f-7bfa42d3a853	832ed194-774b-46c3-8ef7-27abb084324d	f
a3282fc4-8a2a-45da-a49f-7bfa42d3a853	689569d2-a88d-42c9-910a-b6d626dddf6e	f
a3282fc4-8a2a-45da-a49f-7bfa42d3a853	71cc9248-d579-4c0e-8663-a2656961ae1f	f
a3282fc4-8a2a-45da-a49f-7bfa42d3a853	4bdf1d1a-8eb1-491d-b08d-3f86451861d2	f
7515e33c-65b7-4518-ad98-3711bbbc8f9c	e398020c-1ec1-487e-9584-34a75459de0e	t
7515e33c-65b7-4518-ad98-3711bbbc8f9c	7fa04efb-e52a-40d9-9c91-5caee279c390	t
7515e33c-65b7-4518-ad98-3711bbbc8f9c	76459466-f04e-48c4-9264-e85d88f829f1	t
7515e33c-65b7-4518-ad98-3711bbbc8f9c	53305b8b-f82e-4974-a0c8-0c119305275d	t
7515e33c-65b7-4518-ad98-3711bbbc8f9c	4b0e37e8-57e4-4bb8-8634-f49ff60e1cbc	t
7515e33c-65b7-4518-ad98-3711bbbc8f9c	832ed194-774b-46c3-8ef7-27abb084324d	f
7515e33c-65b7-4518-ad98-3711bbbc8f9c	689569d2-a88d-42c9-910a-b6d626dddf6e	f
7515e33c-65b7-4518-ad98-3711bbbc8f9c	71cc9248-d579-4c0e-8663-a2656961ae1f	f
7515e33c-65b7-4518-ad98-3711bbbc8f9c	4bdf1d1a-8eb1-491d-b08d-3f86451861d2	f
f1a52f57-a2b2-48cf-a798-f4855efd1bbc	e398020c-1ec1-487e-9584-34a75459de0e	t
f1a52f57-a2b2-48cf-a798-f4855efd1bbc	7fa04efb-e52a-40d9-9c91-5caee279c390	t
f1a52f57-a2b2-48cf-a798-f4855efd1bbc	76459466-f04e-48c4-9264-e85d88f829f1	t
f1a52f57-a2b2-48cf-a798-f4855efd1bbc	53305b8b-f82e-4974-a0c8-0c119305275d	t
f1a52f57-a2b2-48cf-a798-f4855efd1bbc	4b0e37e8-57e4-4bb8-8634-f49ff60e1cbc	t
f1a52f57-a2b2-48cf-a798-f4855efd1bbc	832ed194-774b-46c3-8ef7-27abb084324d	f
f1a52f57-a2b2-48cf-a798-f4855efd1bbc	689569d2-a88d-42c9-910a-b6d626dddf6e	f
f1a52f57-a2b2-48cf-a798-f4855efd1bbc	71cc9248-d579-4c0e-8663-a2656961ae1f	f
f1a52f57-a2b2-48cf-a798-f4855efd1bbc	4bdf1d1a-8eb1-491d-b08d-3f86451861d2	f
7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	e398020c-1ec1-487e-9584-34a75459de0e	t
7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	7fa04efb-e52a-40d9-9c91-5caee279c390	t
7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	76459466-f04e-48c4-9264-e85d88f829f1	t
7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	53305b8b-f82e-4974-a0c8-0c119305275d	t
7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	4b0e37e8-57e4-4bb8-8634-f49ff60e1cbc	t
7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	832ed194-774b-46c3-8ef7-27abb084324d	f
7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	689569d2-a88d-42c9-910a-b6d626dddf6e	f
7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	71cc9248-d579-4c0e-8663-a2656961ae1f	f
7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	4bdf1d1a-8eb1-491d-b08d-3f86451861d2	f
a6b150e6-04e7-4502-b55c-35a8d1b66eb0	e398020c-1ec1-487e-9584-34a75459de0e	t
a6b150e6-04e7-4502-b55c-35a8d1b66eb0	7fa04efb-e52a-40d9-9c91-5caee279c390	t
a6b150e6-04e7-4502-b55c-35a8d1b66eb0	76459466-f04e-48c4-9264-e85d88f829f1	t
a6b150e6-04e7-4502-b55c-35a8d1b66eb0	53305b8b-f82e-4974-a0c8-0c119305275d	t
a6b150e6-04e7-4502-b55c-35a8d1b66eb0	4b0e37e8-57e4-4bb8-8634-f49ff60e1cbc	t
a6b150e6-04e7-4502-b55c-35a8d1b66eb0	832ed194-774b-46c3-8ef7-27abb084324d	f
a6b150e6-04e7-4502-b55c-35a8d1b66eb0	689569d2-a88d-42c9-910a-b6d626dddf6e	f
a6b150e6-04e7-4502-b55c-35a8d1b66eb0	71cc9248-d579-4c0e-8663-a2656961ae1f	f
a6b150e6-04e7-4502-b55c-35a8d1b66eb0	4bdf1d1a-8eb1-491d-b08d-3f86451861d2	f
47820472-954a-4742-9cb3-cf82d38e5190	e398020c-1ec1-487e-9584-34a75459de0e	t
47820472-954a-4742-9cb3-cf82d38e5190	7fa04efb-e52a-40d9-9c91-5caee279c390	t
47820472-954a-4742-9cb3-cf82d38e5190	76459466-f04e-48c4-9264-e85d88f829f1	t
47820472-954a-4742-9cb3-cf82d38e5190	53305b8b-f82e-4974-a0c8-0c119305275d	t
47820472-954a-4742-9cb3-cf82d38e5190	4b0e37e8-57e4-4bb8-8634-f49ff60e1cbc	t
47820472-954a-4742-9cb3-cf82d38e5190	832ed194-774b-46c3-8ef7-27abb084324d	f
47820472-954a-4742-9cb3-cf82d38e5190	689569d2-a88d-42c9-910a-b6d626dddf6e	f
47820472-954a-4742-9cb3-cf82d38e5190	71cc9248-d579-4c0e-8663-a2656961ae1f	f
47820472-954a-4742-9cb3-cf82d38e5190	4bdf1d1a-8eb1-491d-b08d-3f86451861d2	f
9d270c10-830e-45fa-ac7d-f919ab5b73cd	832ed194-774b-46c3-8ef7-27abb084324d	t
9d270c10-830e-45fa-ac7d-f919ab5b73cd	e398020c-1ec1-487e-9584-34a75459de0e	t
9d270c10-830e-45fa-ac7d-f919ab5b73cd	7fa04efb-e52a-40d9-9c91-5caee279c390	t
9d270c10-830e-45fa-ac7d-f919ab5b73cd	76459466-f04e-48c4-9264-e85d88f829f1	t
9d270c10-830e-45fa-ac7d-f919ab5b73cd	53305b8b-f82e-4974-a0c8-0c119305275d	t
9d270c10-830e-45fa-ac7d-f919ab5b73cd	4bdf1d1a-8eb1-491d-b08d-3f86451861d2	t
9d270c10-830e-45fa-ac7d-f919ab5b73cd	4b0e37e8-57e4-4bb8-8634-f49ff60e1cbc	t
9d270c10-830e-45fa-ac7d-f919ab5b73cd	689569d2-a88d-42c9-910a-b6d626dddf6e	f
9d270c10-830e-45fa-ac7d-f919ab5b73cd	71cc9248-d579-4c0e-8663-a2656961ae1f	f
47820472-954a-4742-9cb3-cf82d38e5190	1ab56eb4-8970-4b91-8807-45ee7e579c6f	t
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
abffa3df-9848-42b2-9cd8-b794d6276323	0754fdba-2315-4f78-a586-fd8fb9184bd0
71cc9248-d579-4c0e-8663-a2656961ae1f	3f628e2a-115a-44f2-bc25-a6c8854cd5fb
832ed194-774b-46c3-8ef7-27abb084324d	2a2068a7-6ed5-4b6c-af6f-bf3fe058de3c
e398020c-1ec1-487e-9584-34a75459de0e	2a2068a7-6ed5-4b6c-af6f-bf3fe058de3c
e398020c-1ec1-487e-9584-34a75459de0e	2921b191-ba86-4827-8b6d-d0bbab82002f
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
7dc9f5c9-3dc5-475a-933f-5ab3997e982c	Trusted Hosts	1cc45988-1774-48f1-af0c-82610082f679	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	1cc45988-1774-48f1-af0c-82610082f679	anonymous
d7c5ace3-e448-47d7-b866-d56a3ca9795d	Consent Required	1cc45988-1774-48f1-af0c-82610082f679	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	1cc45988-1774-48f1-af0c-82610082f679	anonymous
4b203ecf-4d4d-46f2-b076-832335576a54	Full Scope Disabled	1cc45988-1774-48f1-af0c-82610082f679	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	1cc45988-1774-48f1-af0c-82610082f679	anonymous
4c2e700d-34ce-4293-a5b1-bbf23a2f5045	Max Clients Limit	1cc45988-1774-48f1-af0c-82610082f679	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	1cc45988-1774-48f1-af0c-82610082f679	anonymous
cdeee1dc-481c-4a06-b2d8-77a32cbaa49f	Allowed Protocol Mapper Types	1cc45988-1774-48f1-af0c-82610082f679	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	1cc45988-1774-48f1-af0c-82610082f679	anonymous
a38df15b-be66-4f93-933f-e6a7d21ec916	Allowed Client Scopes	1cc45988-1774-48f1-af0c-82610082f679	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	1cc45988-1774-48f1-af0c-82610082f679	anonymous
5527dbed-0efe-4f79-96ec-b4775c2503fd	Allowed Protocol Mapper Types	1cc45988-1774-48f1-af0c-82610082f679	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	1cc45988-1774-48f1-af0c-82610082f679	authenticated
81e10448-ae0e-473d-b9ee-cda4fe395510	Allowed Client Scopes	1cc45988-1774-48f1-af0c-82610082f679	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	1cc45988-1774-48f1-af0c-82610082f679	authenticated
b2fb4a1c-a052-4f6b-968b-b4723eff506e	rsa-generated	1cc45988-1774-48f1-af0c-82610082f679	rsa-generated	org.keycloak.keys.KeyProvider	1cc45988-1774-48f1-af0c-82610082f679	\N
28110b3c-668c-4e0d-9946-28e8e3b28fce	rsa-enc-generated	1cc45988-1774-48f1-af0c-82610082f679	rsa-enc-generated	org.keycloak.keys.KeyProvider	1cc45988-1774-48f1-af0c-82610082f679	\N
f481b10e-b351-4881-b385-bad8d8e5acfb	hmac-generated	1cc45988-1774-48f1-af0c-82610082f679	hmac-generated	org.keycloak.keys.KeyProvider	1cc45988-1774-48f1-af0c-82610082f679	\N
91b1a5df-daf9-46b7-bee1-5811497d0ec0	aes-generated	1cc45988-1774-48f1-af0c-82610082f679	aes-generated	org.keycloak.keys.KeyProvider	1cc45988-1774-48f1-af0c-82610082f679	\N
e3ebc68a-577e-4081-b4df-5e31a763cd23	rsa-generated	fd31cefa-d2de-4b30-884e-96a0a709f62d	rsa-generated	org.keycloak.keys.KeyProvider	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N
a18f3e2a-6f8f-4d6e-89a2-480eb815c5e6	rsa-enc-generated	fd31cefa-d2de-4b30-884e-96a0a709f62d	rsa-enc-generated	org.keycloak.keys.KeyProvider	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N
a465ab41-9da5-4b0e-ab98-b27bb1603cc5	hmac-generated	fd31cefa-d2de-4b30-884e-96a0a709f62d	hmac-generated	org.keycloak.keys.KeyProvider	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N
d81719b4-2f54-42ec-a37a-b2b662b0733a	aes-generated	fd31cefa-d2de-4b30-884e-96a0a709f62d	aes-generated	org.keycloak.keys.KeyProvider	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N
d2907475-d88c-47ae-a95d-7e25f437dd8f	Trusted Hosts	fd31cefa-d2de-4b30-884e-96a0a709f62d	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	fd31cefa-d2de-4b30-884e-96a0a709f62d	anonymous
bb82bc8b-cb4b-4f23-acb0-7894206f82ba	Consent Required	fd31cefa-d2de-4b30-884e-96a0a709f62d	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	fd31cefa-d2de-4b30-884e-96a0a709f62d	anonymous
abbf6fc3-2191-496e-a5e9-4f2ae1888cf4	Full Scope Disabled	fd31cefa-d2de-4b30-884e-96a0a709f62d	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	fd31cefa-d2de-4b30-884e-96a0a709f62d	anonymous
1039d15a-26f5-4f97-9eb9-19eaf99a650c	Max Clients Limit	fd31cefa-d2de-4b30-884e-96a0a709f62d	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	fd31cefa-d2de-4b30-884e-96a0a709f62d	anonymous
c2d51320-6bfd-43c4-a9ec-592731601bce	Allowed Protocol Mapper Types	fd31cefa-d2de-4b30-884e-96a0a709f62d	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	fd31cefa-d2de-4b30-884e-96a0a709f62d	anonymous
d375db6f-7b21-4dc9-b066-45154a8f3265	Allowed Client Scopes	fd31cefa-d2de-4b30-884e-96a0a709f62d	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	fd31cefa-d2de-4b30-884e-96a0a709f62d	anonymous
116b02d4-4ae6-44f5-b3c8-c693e35d3536	Allowed Protocol Mapper Types	fd31cefa-d2de-4b30-884e-96a0a709f62d	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	fd31cefa-d2de-4b30-884e-96a0a709f62d	authenticated
021300e0-3ea7-44ad-bf8a-447c141e0c9e	Allowed Client Scopes	fd31cefa-d2de-4b30-884e-96a0a709f62d	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	fd31cefa-d2de-4b30-884e-96a0a709f62d	authenticated
b85de0a2-635f-434d-9ea8-28e2a73df660	\N	fd31cefa-d2de-4b30-884e-96a0a709f62d	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N
cc44ea46-e0b5-40c1-8cc6-9cdaf38bdcd5	\N	1cc45988-1774-48f1-af0c-82610082f679	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	1cc45988-1774-48f1-af0c-82610082f679	\N
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
29ae10a9-b878-4d45-b9d5-b2e7ef101697	a38df15b-be66-4f93-933f-e6a7d21ec916	allow-default-scopes	true
8da09efb-1fe5-45ec-ba46-e9b985df6d67	7dc9f5c9-3dc5-475a-933f-5ab3997e982c	host-sending-registration-request-must-match	true
302b9082-83cd-4a62-af98-108698e58af6	7dc9f5c9-3dc5-475a-933f-5ab3997e982c	client-uris-must-match	true
76d4bcde-b180-4ae6-95e2-34fbcf9eb6f6	5527dbed-0efe-4f79-96ec-b4775c2503fd	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
2e527485-bb17-4a8c-94c0-d48b40ed3b0d	5527dbed-0efe-4f79-96ec-b4775c2503fd	allowed-protocol-mapper-types	saml-user-attribute-mapper
93dfb4c5-db62-4f11-80e2-46c3bd85531a	5527dbed-0efe-4f79-96ec-b4775c2503fd	allowed-protocol-mapper-types	oidc-address-mapper
c338450e-39b7-4a86-b755-331223856ebc	5527dbed-0efe-4f79-96ec-b4775c2503fd	allowed-protocol-mapper-types	oidc-full-name-mapper
f40aabaf-2ec2-4ddd-b9b2-12ad561770d9	5527dbed-0efe-4f79-96ec-b4775c2503fd	allowed-protocol-mapper-types	saml-user-property-mapper
86572e67-7011-43ac-8357-e314d7aae254	5527dbed-0efe-4f79-96ec-b4775c2503fd	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
ebe8f967-9118-4393-b5a1-9f4659ecd92f	5527dbed-0efe-4f79-96ec-b4775c2503fd	allowed-protocol-mapper-types	saml-role-list-mapper
11e90fde-9115-4ae3-bfd1-3b4d40ce1ea2	5527dbed-0efe-4f79-96ec-b4775c2503fd	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
a8a71ccb-63a5-4fa5-9ebe-5f5f7074de92	4c2e700d-34ce-4293-a5b1-bbf23a2f5045	max-clients	200
0bc2ee82-bdfd-458a-8946-6750b7657657	81e10448-ae0e-473d-b9ee-cda4fe395510	allow-default-scopes	true
7102594e-886b-41d0-a80f-c7f9c925fc15	cdeee1dc-481c-4a06-b2d8-77a32cbaa49f	allowed-protocol-mapper-types	oidc-address-mapper
154a06c7-734f-41d0-9643-77043af15233	cdeee1dc-481c-4a06-b2d8-77a32cbaa49f	allowed-protocol-mapper-types	saml-role-list-mapper
09ed3cd5-5887-480a-9c4a-58d07604404d	cdeee1dc-481c-4a06-b2d8-77a32cbaa49f	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
7c71dec2-b069-4336-b5f1-f58e79eef399	cdeee1dc-481c-4a06-b2d8-77a32cbaa49f	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
4e38d0ed-db53-4086-bed6-a0ef8f7a3131	cdeee1dc-481c-4a06-b2d8-77a32cbaa49f	allowed-protocol-mapper-types	saml-user-attribute-mapper
afb54b15-1f1f-493f-8050-893ed29a53c7	cdeee1dc-481c-4a06-b2d8-77a32cbaa49f	allowed-protocol-mapper-types	oidc-full-name-mapper
bdd51697-2aed-47aa-885d-85c1cfa77b4c	cdeee1dc-481c-4a06-b2d8-77a32cbaa49f	allowed-protocol-mapper-types	saml-user-property-mapper
14d03493-15db-4c84-96a9-7f15bc7be7a9	cdeee1dc-481c-4a06-b2d8-77a32cbaa49f	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
192f3fcb-1fe8-454e-89e7-f3376074210b	b2fb4a1c-a052-4f6b-968b-b4723eff506e	priority	100
23574105-d90a-4a78-bfca-5d87ad3fcd74	b2fb4a1c-a052-4f6b-968b-b4723eff506e	privateKey	MIIEogIBAAKCAQEAxat/KLTRMpRKuCij6BO5VjC3bKAkrRI+WXPz7c+3qL22MK1RgIxxMqAVJKymacG7J7h1LrBirB+lyESaWIZKOzXjPVVRmNiFQAsEdq+V02tO9NspNZE1YvcqPzUot8h+IK0Zb26pcWQo1j28Z/udaccxuNAT6etvIlaQFhG6w/ENvxuoWHYFhh8rpCsRLjYbdFcy35+eYUCyjy4qr36iVQ/1v6xOwpl+uF6QA/6cVyJpmUYsuQ+pyK+C/GUhbppXSlzg+Dd01bJ9gveOt49VCcR0hA6nJzM75NruJWHUfPEaOKMLPWUUj6SUjwborBo6uIFClr3UNcKPp3Oi7SsZAQIDAQABAoIBAE8d6ERrsvuynQF+yrPeCSV1VEU3B9b54Vi+b1i09galACIVjPSNwdUIe831CJp1vyoTy1tHoAbSl/FDfB+IiHeQhwaKeqFZsGPExSGX/7jiT3Tzr1fQafTVhuRLq6N7rPf5MKAIQ+utsiamCR35eLTY1I7rQb0zzYSJ7xvWNtGrmsISsTm+HEUu9ePWRY1ZcFuWutJDT8jTfj49FB3Y8Ko4CBpeTeJsosA3RqXq0AzG6qjgvJuj/tWNnhmtEZtRpXIGqO2KCZd1DJJnZFA945HPdgQnAgwyJk4SyHmnT8NGO221FIkdOHp4eGpm0ei35rAY4oK0rFLUjL7INvbntt0CgYEA5MDIyMMmQ/MOJ8+9VIssssaF4PJzvoqfIh5P/faYJ9719MVaBQVTk9p8FZJzz3IpMtNBn6ToRw5opUXB1Rka+26D4cnVWewLV4hnD1fXO/37CB7yqxLt2RhC7h7PjcJ3S/wQqg4utehPTB1aKr98OPZAIabgJlT9jIvw9GeyKK8CgYEA3TbqEtNq2SaCiT5OqzNPiwqtjDM+LsB+dXVpojoJZwTbHt353XEB+vEmScpyPHVp4erJmWu1rvkLj7GNMzWZ5aVUkkOKwv6rI8JKteTMBMnSilm4RT5mkCsuckP124ti868nCHqbQdFHnHHgnrzTuojOApRPj9fhRRZ8GLj05U8CgYBUGF94Fu4RWuBgWGm1E/kZvAvpt5g/ezynUVd8+NPVDI2FL6w5XkzsdQza7V0v7TsiGTHt27UcsjpcT/nDOpiFyIopToblqPY+dsHUjSluP5+yy5XQuIPCJL4uRhttdQlgYMlLiy026LGGPOAyCPVFB5pqBKwwy1vu+F9bqmd/twKBgERfVLm83ql/XZlNyMLheRRgmINc0ztgA7YKNDwP9BgDSDaiJThsVVBaeJsWF3jYUYGiL+1bfSw3jXs8RYguaQKxtxH+DkV2sS68Pps5vFU+i/R3Bp1gTBMDRbfLiZHx4wOuf0H/oz0Uki2ohOSLOGXPIt1pOa4b62SPLov1nrvBAoGALHSbbYpVM9kAbw3Ai0RWFLam25RlsKdWLEJUIro54d1V/YhqEyBv3CLbS0On9PCJLXzwjDvuRwjvSTokacX3JSmHDLvRoTLUMpfKCO5xHMnwTm6wyfMaNId5nzT+NFmFyZJ/D+gYuvjXI9+TvbXbi+zc/1R+69pkhXTCZ+THP34=
45ee80b4-ed9f-4305-9466-0beb1ade38a4	b2fb4a1c-a052-4f6b-968b-b4723eff506e	keyUse	SIG
219411e1-1f48-4904-87a2-e55e21de2427	b2fb4a1c-a052-4f6b-968b-b4723eff506e	certificate	MIICmzCCAYMCBgGJT60M0TANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjMwNzEzMTQzMzA4WhcNMzMwNzEzMTQzNDQ4WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDFq38otNEylEq4KKPoE7lWMLdsoCStEj5Zc/Ptz7eovbYwrVGAjHEyoBUkrKZpwbsnuHUusGKsH6XIRJpYhko7NeM9VVGY2IVACwR2r5XTa0702yk1kTVi9yo/NSi3yH4grRlvbqlxZCjWPbxn+51pxzG40BPp628iVpAWEbrD8Q2/G6hYdgWGHyukKxEuNht0VzLfn55hQLKPLiqvfqJVD/W/rE7CmX64XpAD/pxXImmZRiy5D6nIr4L8ZSFumldKXOD4N3TVsn2C9463j1UJxHSEDqcnMzvk2u4lYdR88Ro4ows9ZRSPpJSPBuisGjq4gUKWvdQ1wo+nc6LtKxkBAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAF7sof6uaQ8WFfMbNMa2WZgVqVsX6gkwELKdJTbiR2rPQbUFlrP4atM9ajFlHZVFt6mckmbVRJWEoaE1iYDL5PkaQcsvzxfkXuKRL6bFHV0wC08Qk9ls7uMOpmnQxriYGDSazIKOaDYXZpHsA5Cjo3wKxyWwi17/PkXgE9hGW5lmFO0sl3jjYmT6C83JJ4FHZPw/OErBw28uxYKq6kY4a6C53C9bvpFlAGkKB/uIdikfszPDg/KIEnf1++5jc0Fe8l7aeIfYvKAgvCuC4Ny1Txpf/JMxLr2soAq2TDdR04plHHjIhtZEg+SRkFbDzY2itE1qFvKScMvOwnWFsh4HWvM=
28547454-ca67-49de-9777-0f57b29a21d1	28110b3c-668c-4e0d-9946-28e8e3b28fce	algorithm	RSA-OAEP
2ab430e7-8834-4965-8559-4b7b06e9c9f0	28110b3c-668c-4e0d-9946-28e8e3b28fce	keyUse	ENC
5b46d367-f875-4485-89e4-735533fd24f0	28110b3c-668c-4e0d-9946-28e8e3b28fce	privateKey	MIIEpAIBAAKCAQEAja0mAZPatMsE8uUex6gPss836Mbcr4hWRQSqNOMCucCgp82wV++mCjooAZKJRhsfifAfCWJZEfEWKvtCk2oPSaOUffTEFbFZ7bNitjOk4yhHm3q0JxN9ybWSEB2+AtRwg9wfrT52JNizekNq3vibdB89qZZaAUfx3kQKcrUT2/RaDIwrLe9JJJDI0/9IdhNLEUeB+vwxGWBlJoLmu0n3qQW/pSaMTPwVHgNE7BFfd62CeFi8mlbe3QfAEHm5GHX3PiUhpbKYPtpILGZgDKNpazqfV9vrI2rw6N6/heUjPvbVIFbCOA2xc6WeqyuBR3j7+TfLSKjkHpWRH5/9v5KnzQIDAQABAoIBAAqTlQVEIO0jRNTPNvuHt9hM8OsPQXVXM72GSiCVm+P7FeNBDzuZV+dmjQsFAft6VeHpy59bOLQGr/V4eXFg1xBTxmeayLKn4UNGA4X/l/0fSi04vU83fMn8pJFQbxlt+5JUcgbwZUh95vQnKUjI/W3vUR6ia0iyMsO5h6AllXxzhni2cZVT+ah8CoVvimCm2eQdc6tAOlbBzHUE7SDQSPwkOlgMdFCISV4AwkLDveAzXn9OGu7IS3/6hR+Pk7kuQGgETqTSFdxNLN2H/s/A3UHSHj366+Dv16DDT/o2Ff6pyvUT1ptCw3cU4Xm+l5gXoHRgR/lAwXKLVwLMFufVwi8CgYEAxz1QKhU6wvlgX3DOjKC8YWkYx4qAJmtM0z2OGn104J3oJu5UAOj8XhpLAWTFJPJRmiFzKsDWZHqyDYnCRRM+EpwS76BXkUPfaISyHgZsmbZ5XLM6H1gBJLd6eW1pvrS489U9yKiIS+kmcWpObymjqgT0i7mEbI831DMkFiMMr4sCgYEAtgm2RbTdtF+v0p094Id+foyq9YekzFXm0iX/21nUrpSWn/+/c/nTgWso4SgDirZFIsb/Z+QPQhgjCpxyeVgThc5hESDDCjRM1P8EAmkFSQMKJU9OvM+WdB/drm4v4ILSm4ZXEzHXCbgAXTqUvWs8jgybjfdjUzRiVvYbRqno8QcCgYEAmCRk283cUljV0+uzfkWbtJLpni5QD4ZuYvylT+svXfqW9WuW8B753+4aCpVlygHUeGtEo4gf7xiWcKoalF7OTq2p9Bwv4ji/F/QEg9MKCRMDd9tQ7fBo5x3Iw4LedgdRGLlkdZ7kfXsrpP21qUNVvBYOm8ftrGxtCHiI/PKE1GMCgYBtsnqRlQWJPaRRcgootN3oWtJm9V+89wMKnnWJdJ+yuL3wGwj/VYw8UBwpWpiPzXjqFSsyKv9639q1+UMOlqHlH1HlJW4DRzMJo8eBwFG8BsXlZ95V726F+fH3vFTDoXJS4Gi2m3EvXR9zDus1Hls2aqiOq4bCTC36o4IaWieSnwKBgQDG91Ycd1e+3l4LTtufcMWt1BPATPGQG3Fnmd7vechmMqVagAvxse1sym0CHhrPdkeBOS8ag6CycqhnOI/xbnUfjCgHHTCzFAgPHcXAMVSe+UHX1SgF624c2xd74rdXQnAbZAV4c2G0NKTWYhO2EbBGSoR3aD8RyLNHrzRqmM8joQ==
c7f0a5c2-b2c1-460a-bcc2-5716fb334a7e	28110b3c-668c-4e0d-9946-28e8e3b28fce	certificate	MIICmzCCAYMCBgGJT60NdDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjMwNzEzMTQzMzA4WhcNMzMwNzEzMTQzNDQ4WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCNrSYBk9q0ywTy5R7HqA+yzzfoxtyviFZFBKo04wK5wKCnzbBX76YKOigBkolGGx+J8B8JYlkR8RYq+0KTag9Jo5R99MQVsVnts2K2M6TjKEeberQnE33JtZIQHb4C1HCD3B+tPnYk2LN6Q2re+Jt0Hz2plloBR/HeRApytRPb9FoMjCst70kkkMjT/0h2E0sRR4H6/DEZYGUmgua7SfepBb+lJoxM/BUeA0TsEV93rYJ4WLyaVt7dB8AQebkYdfc+JSGlspg+2kgsZmAMo2lrOp9X2+sjavDo3r+F5SM+9tUgVsI4DbFzpZ6rK4FHePv5N8tIqOQelZEfn/2/kqfNAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAFwlmcysdB813p2QPL4LL6aG6BVUqF7tZkxsB984GRu0LmZHRtxKeqXP2qAmj0EkZ3I3pNOn+Cu9uuYC8TBi7eEcWCUFgMctjT52IFmyiWL6bukDZ2joRvdYsoqd+WiU3mxi+kQ99MWjtXHV3E0sPpEO+unicvERb8+yh4+iQQdpY5RV3/cR+bVALjOazUOcVootAWnSlotJa/pJxE4Haz7NzcKLGSlwpoPVvC4YJgQek4LflmTDujPyRMIn4rwdeH44zsQrrpCnNRC4KRZcEXlrLmcp3+OwwI97ekTwCxnovPx3vA3r4TYA5g43olNeObOtJIHaNLjpZldeHZ51/HY=
76365a56-31e6-4a74-b69f-94abc69ff71c	28110b3c-668c-4e0d-9946-28e8e3b28fce	priority	100
9abb74e6-d7f0-4da2-ab72-51e1a96e00a2	f481b10e-b351-4881-b385-bad8d8e5acfb	algorithm	HS256
0f93091e-2c8c-42a2-8b2f-5d716b0dabc7	f481b10e-b351-4881-b385-bad8d8e5acfb	secret	Tjei6nlEUQFY_3JvIgZeu0ZdE15dGRlZipAzxwIuyO3gjce4mTD5uPN_8023_0PV9kYkn-kAVzcF-hTMerCiTg
363f01eb-dbb9-4af7-b87c-6177a51d062b	f481b10e-b351-4881-b385-bad8d8e5acfb	kid	7ddff8e6-a92b-45c6-9ef2-c3b1e60f9806
b72b5cbf-5fb7-4900-aa08-bac52deb7325	f481b10e-b351-4881-b385-bad8d8e5acfb	priority	100
a0509be6-dd89-4edb-ad16-6483d4bf24c6	91b1a5df-daf9-46b7-bee1-5811497d0ec0	priority	100
f036af11-77de-4345-ad96-24034f82fed1	91b1a5df-daf9-46b7-bee1-5811497d0ec0	kid	8b0dac14-3e70-47c2-bc82-b223b342198c
89b85a89-1e21-4837-83e6-a5640b0f857f	91b1a5df-daf9-46b7-bee1-5811497d0ec0	secret	xngXNJkCyU3UKa1irYq6pg
700b63f5-bc25-4dca-b8c2-dc639a5a573d	a18f3e2a-6f8f-4d6e-89a2-480eb815c5e6	priority	100
d296dcbd-1f90-43ac-854f-c33a62e4b284	a18f3e2a-6f8f-4d6e-89a2-480eb815c5e6	certificate	MIICnTCCAYUCBgGJT62cxzANBgkqhkiG9w0BAQsFADASMRAwDgYDVQQDDAdtYXBzLWVoMB4XDTIzMDcxMzE0MzM0NVoXDTMzMDcxMzE0MzUyNVowEjEQMA4GA1UEAwwHbWFwcy1laDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAOML8zG/sQowilPBOwOzNTWg8w3+Gt+yH+4ch1pJSqqe5vbgiKBQmsJUWp/KVdyjVYC0JKTNuo/GXpOao5jQxP9euzMX5bZd+T5EYXhsL6r+bc2W914O1bOv4pT6vUFhNwDahubKeHLjScY/mK6Jif0oliNugIHNjUWVEvJUv8E/lsPZ1IN9CVm3K2bfErSV/ou29xcIt6BJb3HMkiN4YvJCEnVmy7vQzvmol/O5XheTj47pCammGOLrbEo7A6XK5oOjP4WjtYTVP8Ni2KU0sP5LMjuogkVlUipYov6zGJl6va3EY8908UFdab2u69ALoWf3VYPl0ubokzy2qjbW+/kCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAU/6+evblGNmbmnvMoBZ3qJa+HH7ROmJCGYhfMwvMLHLqIlA8qSMR751Um84qyCe7K9s5MEJMCeEAX2TCqMBkG/KgVPACN96vM/LAceEPF3UhZmlxKSjJLsv9Ne/GvV6lX7jb1eqW88qn96GgLDZsUKiUxkyWfRABNDijWfgSulPXG9ja+dCY6u7zGHrSRKs2KhoTNM4Xj+/nmTxRTONL47pYVOTobb4BPOFZFIdL2O5z47kNscLKBhRy9e1uIjaE+n8fdreefmb/oIxlWXi1tQSExSp6UZz26RdHfTV80TChWSwjcTgGOxX6Gv9Ieky4YZsauBuh7se49bZrNATIrg==
ac731a19-29cc-4e4b-ad88-2ff53b04b0d8	a18f3e2a-6f8f-4d6e-89a2-480eb815c5e6	privateKey	MIIEowIBAAKCAQEA4wvzMb+xCjCKU8E7A7M1NaDzDf4a37If7hyHWklKqp7m9uCIoFCawlRan8pV3KNVgLQkpM26j8Zek5qjmNDE/167Mxfltl35PkRheGwvqv5tzZb3Xg7Vs6/ilPq9QWE3ANqG5sp4cuNJxj+YromJ/SiWI26Agc2NRZUS8lS/wT+Ww9nUg30JWbcrZt8StJX+i7b3Fwi3oElvccySI3hi8kISdWbLu9DO+aiX87leF5OPjukJqaYY4utsSjsDpcrmg6M/haO1hNU/w2LYpTSw/ksyO6iCRWVSKlii/rMYmXq9rcRjz3TxQV1pva7r0AuhZ/dVg+XS5uiTPLaqNtb7+QIDAQABAoIBADLmJursMmA6aYhFNVmq/y66mkJ0yMmFQSs8MgvHinmdjeGijH6EE22lQ3u2/HCuHSjxOZXImR5KNkGY1TwY8VDeh9D4doLfplSTN9arSjRnPW5tfZ8UbEwQDhef7nWNuarzUnLCySXYVl2fPDdEli6uvpnK1/xBfH4w4UJ6RVKo5qZ9M8afv/+M/b1wBVltAxMeDOht2LD5Zk3i43mv6IK0AVvDZe2OWMUuygANqFueyaCHvK0H88WMu2x+0Dh4K8SZerW4XrzgTGCKTVlS5EmNoa7earwC4QPd7eU8Rz7DhKKhdBS4dvQtR/emqECXw2/lUVStOJjaSlyAvtPJ71ECgYEA8q9/Jis7Hk114zjJio7raqls3iLmPutXmR+kbVWhYVEpZlRF6LAJFgFbzPSxgJg73zTfTFjBsV5xzxXeNWtwRN+SrFKMTe42jo7h7aqCkMPQVkdh2lZDFJVy/9L0DfvZfUk4iDVVGywwZMdZUPkXQN1YlX5ka8WjvaVCXT8Eif8CgYEA74DOerOjumk28bZh3z6B3Y1gv7KAQ+V808EqJCqwJXpntWc7NASqjF8cpWEr0naBfF55lV2izgRKwpxh4Yv2nGZuHxjU1dQcMjN7K3TNWYMkKx9HHa5bPEd7LZryMPdaPW2SFVf4vdETt3Eqdq341lYxuKsh9uFgGZFn+c8sygcCgYB66ioDAfhSU7c2m2dwdwyDHEaYh6KIEZhvZJhaC/nNmVbXji1OOgKQE6YUO4a/c9s3JMdIGtgXZpdL5G6ELeNR7s6R2slXGySktXd2cVrpyVN2r3a/J9uXzE3Phl+3yWwRSYmJa0GsnofwMwtouJBveOxJ4xcngpV5Ev92zNkWrwKBgEnIptPKT+B31YN1qoU6HowAqBOmjDlek6ww0CjANe/128lY+jY2UcxY6NxSKUv3UkDcYhyP8j4BuH5n6wevNNROAhL2dWtCo0Ub8xAaNcEj05qtUh1kv5q8cshD+eT37wcJoH2O0oS3ypky9eAGDKkLeNnpbtc963s0/pFJMAU1AoGBAIaZGUXoTaBxBQ1RnwRL6e0mYpv7DBhQOighSFbpTIVh4dyQhVc5qpu4SIe5sQhNyr3XXz03Glu6GqDAHTR15eZckYtoM15zxdvIAfnv1IMV2DQ4qOnlO3BFhKzNRF3L2Ksy0Fw6CwD4TA2VVVoCMA2s0ugzMI69m9CcicoT4JVT
bba74b59-ae40-420c-b5f9-71504633fad5	a18f3e2a-6f8f-4d6e-89a2-480eb815c5e6	keyUse	ENC
fd9718d2-d7d0-4a9e-9fc9-35c9cbdfabb3	a18f3e2a-6f8f-4d6e-89a2-480eb815c5e6	algorithm	RSA-OAEP
e6510c2c-343e-4711-b9b0-422700c8f143	d81719b4-2f54-42ec-a37a-b2b662b0733a	secret	MDV4z3DDj_EXjSrAB1q3-w
ee68b667-d1c8-4d0a-95d7-8267e6ab0e20	d81719b4-2f54-42ec-a37a-b2b662b0733a	priority	100
55c3a665-1025-42c2-a777-29bff66fd950	d81719b4-2f54-42ec-a37a-b2b662b0733a	kid	10387ff3-0293-4035-ae4f-3d0d172efcdd
be73ccfe-1865-43e8-a3a3-76a3741b8b5d	a465ab41-9da5-4b0e-ab98-b27bb1603cc5	priority	100
5511c101-1311-43ca-a7f4-cec46c118042	a465ab41-9da5-4b0e-ab98-b27bb1603cc5	algorithm	HS256
4c457347-f296-42d4-985b-a452684dc701	a465ab41-9da5-4b0e-ab98-b27bb1603cc5	secret	j1IQLp1mFYb9A4EB4qLqPWQiCuywgwczkN4PHW-Of3ts3HOjKAtk8MJd3pKcymjAdbU9D19PWjFRWk0Ts_hMuQ
41e8bf64-abb6-4a32-a78a-37020122f1d9	a465ab41-9da5-4b0e-ab98-b27bb1603cc5	kid	9b137276-e136-4ce0-ac6e-f520d247579b
ce90d7b8-7a00-4030-a9c1-2392e470d1ce	e3ebc68a-577e-4081-b4df-5e31a763cd23	keyUse	SIG
9dab84d4-0a17-4f15-8e16-f63806724227	e3ebc68a-577e-4081-b4df-5e31a763cd23	priority	100
e76c2680-0e2c-4d03-ac04-c915b7e69bbf	e3ebc68a-577e-4081-b4df-5e31a763cd23	certificate	MIICnTCCAYUCBgGJT62cWTANBgkqhkiG9w0BAQsFADASMRAwDgYDVQQDDAdtYXBzLWVoMB4XDTIzMDcxMzE0MzM0NVoXDTMzMDcxMzE0MzUyNVowEjEQMA4GA1UEAwwHbWFwcy1laDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAJf3AGb0+8DuCyup+fOgkBziEfpLkdxi143Ddz2o1WgDN7DJVCGUUeDIya3AUH4qciOtTQlXdhEKyN0LsY10lA0mi6HJ5L56oCF6OZlsehllAhz2vbBYw7c7O8QwwBt2IfM1VJx/GTXyeBcFUxh21gS7DpFbL3sWqSTYA8BG/1DRXY+hSGbFVdeQa11t3InjiLB1h1LQHKiN7L4+g/zcBwDCe9vsJjCxpQvTJtzhTImHNqGnJ8RNdKewbeMAhX4ULzThHc2MNoFmNlqdfv2zTsLfWQPD9MznnwaykaVz+SdoqcUUWWv2S19GaoxxBT9GJqEiyvRn5HS98p5mDEayfrkCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAUU2O61JM8c2J6IwetbWNA9FjO97ZwOgBCetkHny2xZm6ZpVaEUr1O1QbzV7j5kOBBwb1UeoTXDlbw0vpIX5zMTpZmPygK8htWqZTwCCjU5ArryyhzrS8bk2PZReGaemloQV1hNpC5fU1cvvO1hvF4gf1MZv9CYh3VyywG4iKd8KDJnjot1YPeutCUrkl5XK18pPIXzVY+2c5oNEghh2v8s4zpX5uIDYctZABYq5wJXwFgF+jiYgw7cCY9cybzc8AtF+l13zrsyoK0eM4/WZutjtC4lk1M9P3RzxK6GhuxqoPxtifiGUN/cxbt5KV9Aq2dTmEXDaZP2MqjeaGNK+Kgg==
167d2fb1-5a65-4ad7-b354-fe9a951de5b9	e3ebc68a-577e-4081-b4df-5e31a763cd23	privateKey	MIIEowIBAAKCAQEAl/cAZvT7wO4LK6n586CQHOIR+kuR3GLXjcN3PajVaAM3sMlUIZRR4MjJrcBQfipyI61NCVd2EQrI3QuxjXSUDSaLocnkvnqgIXo5mWx6GWUCHPa9sFjDtzs7xDDAG3Yh8zVUnH8ZNfJ4FwVTGHbWBLsOkVsvexapJNgDwEb/UNFdj6FIZsVV15BrXW3cieOIsHWHUtAcqI3svj6D/NwHAMJ72+wmMLGlC9Mm3OFMiYc2oacnxE10p7Bt4wCFfhQvNOEdzYw2gWY2Wp1+/bNOwt9ZA8P0zOefBrKRpXP5J2ipxRRZa/ZLX0ZqjHEFP0YmoSLK9GfkdL3ynmYMRrJ+uQIDAQABAoIBACSpK5kq//M+2kYJ5ymNskatiV3DTmiHFe522fTvnrBNmmlVYK0LLaeXeQQoUaLmVYvi2qNmzK521hdxoz93gOIdSvFYlg0X4zrAVFX9lAU9V4GqSv/Yojq5mQUPJ8FYQf98/bEVfn0DxlHzcGUGAkK4595MS8ubn2mqjVkdJ6oUwRrjt9ciSfm6xicpmP5949lF+MbU9hu9Zl6ZDuyaxB53CKXvUD8U311Y4+reofK+4of8f4kOK7WbHvnd3ZmwmadTvi9hjHRX70YU86sh1Qd52yC/xi93SFQAg3hGx0YNW+710F3FZKKf5yxqqKF3QkF+jcQTtqMWHmfKh3hqEskCgYEAyAGXyCQq0myh1NBtKGhC+vrouATDE+Hbt9wPJbAVozxhyZLxVVslFjzoArto3XwGjftmkfuXvlHwA90LFWNA9J5HX97dpaavH+mHTiP90Qr5+ME9N/0IRuQyaXf81LHEuxrW9mtkWGrw/LWC7EJUbDrNldwGcOjQyNdwpe2Pel0CgYEAwoJK9/4cO2FVlfodcxh9IOfq3fIHe0G+z2KtDn8BwNNYM7bqFjOQjMwEHNcZz+GqgpGGvmJPSXLsgMXdveWyWI1lr2gE7WRfDye56OzbD70k3L2RtWJaEKbOXysStk9FlUPa73sMbubzWcXVkww3AlXvBFTjwEx/xY9GscdJ6A0CgYAxeQtla2TYRhzFuoS10Qx4bqYwFqV2fpDN6vYoOWUwypfZt6pQlcoXtRsiyd7Hoo0wg7Y8eAJyBmybWAsM0E9Z8uju0v76ob+B4k8gyhBXrCJnIM2W0tVAS+QYaKC2r/5c1efEbo4UvOc9a1ymOkYNu4HtBs7lEQHMHFZ2BMxP1QKBgQChqPKwHJXQUHx2kxNI5pCQ+c/9uTu4mJMDAEs+4hZN8hm7mYoC+8ZnDuVYJvrACRnTPSpVL5YgQJEKEenS+4Z4DMT3vSdjOmm7SdQ9ICaNdTGe+TuSGnUqo8if1kfOGCKIBYaARa+2uOKGuWNhvOQ3X76wxfEokSwcwZELDsyBPQKBgEysbzJoe4IERk223cob0oO2H9bAodva0IBg5P2bk5hGqgWKRAj7cpmIGttVbasgIcFn5vI5LKuyh+YzQO9S7oMgsrBzFRbZqmE4ltRZEgf6R6Zf/vdCNxDIABVtiBMUeuj4inKtEYMrehNJAtnGdQbDKLCGlhGjTo+VeJc6a+hx
dc83604b-cfdf-4140-9d24-9d53aa5db03a	c2d51320-6bfd-43c4-a9ec-592731601bce	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
30c123bf-b2e8-4073-a685-fb2b9406b351	c2d51320-6bfd-43c4-a9ec-592731601bce	allowed-protocol-mapper-types	saml-user-property-mapper
c7375562-cf7a-435b-8c3f-b4fb9178a841	c2d51320-6bfd-43c4-a9ec-592731601bce	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
0b1facc9-b3d6-49b7-bb86-06a1af76bbd1	c2d51320-6bfd-43c4-a9ec-592731601bce	allowed-protocol-mapper-types	oidc-full-name-mapper
7cde9a2c-000f-41d8-857c-43b68168ef3a	c2d51320-6bfd-43c4-a9ec-592731601bce	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
a2dfc842-4bb0-4bbc-abcf-032c68588501	c2d51320-6bfd-43c4-a9ec-592731601bce	allowed-protocol-mapper-types	saml-user-attribute-mapper
29163ca4-9774-4fbd-bf8e-8fd5a1207f15	c2d51320-6bfd-43c4-a9ec-592731601bce	allowed-protocol-mapper-types	oidc-address-mapper
ea1c7ff8-3f61-4b4e-9f84-521d8c2d16c8	c2d51320-6bfd-43c4-a9ec-592731601bce	allowed-protocol-mapper-types	saml-role-list-mapper
e333b9a9-37b2-4606-97b7-292a78653541	d2907475-d88c-47ae-a95d-7e25f437dd8f	client-uris-must-match	true
4d7a02ae-78b2-4fe7-bacc-cc8d41c5a7b8	d2907475-d88c-47ae-a95d-7e25f437dd8f	host-sending-registration-request-must-match	true
c70f6a63-2936-4b15-8089-696cf6c1c17c	d375db6f-7b21-4dc9-b066-45154a8f3265	allow-default-scopes	true
01322461-1e51-443f-8f9b-ce25053d04ec	1039d15a-26f5-4f97-9eb9-19eaf99a650c	max-clients	200
3b1cd1d3-5830-459a-a025-4e4759bbf075	021300e0-3ea7-44ad-bf8a-447c141e0c9e	allow-default-scopes	true
247e2ba6-97bd-448a-802b-f70ef150a7d6	116b02d4-4ae6-44f5-b3c8-c693e35d3536	allowed-protocol-mapper-types	oidc-address-mapper
be6e9628-5232-4e72-944a-9c77095c03c0	116b02d4-4ae6-44f5-b3c8-c693e35d3536	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
a2fc61d5-7dca-4d2e-933f-7d12b1017a01	116b02d4-4ae6-44f5-b3c8-c693e35d3536	allowed-protocol-mapper-types	saml-role-list-mapper
53b8543a-b24a-45b6-b648-bd90e5bba802	116b02d4-4ae6-44f5-b3c8-c693e35d3536	allowed-protocol-mapper-types	oidc-full-name-mapper
b593f2a7-4142-4f91-bc25-f13a9239e806	116b02d4-4ae6-44f5-b3c8-c693e35d3536	allowed-protocol-mapper-types	saml-user-property-mapper
03294700-3070-47a4-98bd-a0ae1e58d03f	116b02d4-4ae6-44f5-b3c8-c693e35d3536	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
3211f64a-799e-475c-971b-7ff26553ad55	116b02d4-4ae6-44f5-b3c8-c693e35d3536	allowed-protocol-mapper-types	saml-user-attribute-mapper
ec470e37-f9ca-4f3b-8aa5-a79d369fdf6f	116b02d4-4ae6-44f5-b3c8-c693e35d3536	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
eba49383-a713-4678-83e8-405f3e4648df	b85de0a2-635f-434d-9ea8-28e2a73df660	config-piece-0	{"attributes":[{"name":"username","displayName":"${username}","permissions":{"view":["admin","user"],"edit":["admin","user"]},"validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}}},{"name":"email","displayName":"${email}","required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"validations":{"email":{},"length":{"max":255}}},{"name":"firstName","displayName":"${firstName}","required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"validations":{"length":{"max":255},"person-name-prohibited-characters":{}}},{"name":"lastName","displayName":"${lastName}","required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"validations":{"length":{"max":255},"person-name-prohibited-characters":{}}},{"name":"formatted","displayName":"Address","required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"selector":{"scopes":["address","microprofile-jwt","roles","offline_access","profile","acr","email","phone","web-origins","role_list"]},"annotations":{},"validations":{}},{"name":"phoneNumber","displayName":"Phone Number","required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"selector":{"scopes":["address","microprofile-jwt","roles","offline_access","profile","acr","email","phone","web-origins","role_list"]},"annotations":{},"validations":{}}]}
355d1a07-d47b-4476-a0fd-3e81467a92ec	b85de0a2-635f-434d-9ea8-28e2a73df660	config-pieces-count	1
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.composite_role (composite, child_role) FROM stdin;
5d073cb7-a36d-4e14-9d15-bd104bcca43f	bb82387b-3eca-4a05-8870-19c2c1021611
5d073cb7-a36d-4e14-9d15-bd104bcca43f	02031fb7-3358-4ce6-bc61-d69755536eba
5d073cb7-a36d-4e14-9d15-bd104bcca43f	d2780a7d-656d-4614-a14a-1194e75b9c08
5d073cb7-a36d-4e14-9d15-bd104bcca43f	d97da3b6-f1f5-44dc-9826-00e899610d43
5d073cb7-a36d-4e14-9d15-bd104bcca43f	f8bed06d-9331-42cd-acd5-5fc7dd060576
5d073cb7-a36d-4e14-9d15-bd104bcca43f	48c2c665-f1f5-431d-a39b-88a2797189a0
5d073cb7-a36d-4e14-9d15-bd104bcca43f	48d15bf6-46fb-423b-9bd0-f38da8038ba1
5d073cb7-a36d-4e14-9d15-bd104bcca43f	7693a5f3-37b9-4771-9008-e1905ef98e2e
5d073cb7-a36d-4e14-9d15-bd104bcca43f	adfa88ef-c678-4c69-a4e4-e3784ba9eefa
5d073cb7-a36d-4e14-9d15-bd104bcca43f	98128e9f-c55b-45a9-89e5-d4516f1a3ed7
5d073cb7-a36d-4e14-9d15-bd104bcca43f	ce5bfa23-eedd-4265-a99c-033cb83ec389
5d073cb7-a36d-4e14-9d15-bd104bcca43f	1e872217-29f2-49ff-8a29-a48bacb91f27
5d073cb7-a36d-4e14-9d15-bd104bcca43f	b95aca36-ddbf-4af8-8a6d-64eb912bca1e
5d073cb7-a36d-4e14-9d15-bd104bcca43f	86c37a24-7e07-42d9-acf8-26e8f8f9a600
5d073cb7-a36d-4e14-9d15-bd104bcca43f	1da69e2a-851d-431c-94ea-93fa1722ec8c
5d073cb7-a36d-4e14-9d15-bd104bcca43f	02a432a3-7b4d-4911-ab1a-c9a39868a4ca
5d073cb7-a36d-4e14-9d15-bd104bcca43f	d7629eaf-1174-4285-8bf6-dfd6c0e34068
5d073cb7-a36d-4e14-9d15-bd104bcca43f	32618d06-a19d-4136-ad7c-79cbb524aa2a
0f2dd4e0-1834-4473-8be0-55a056715089	291b1935-dcce-49c6-9ac9-2af6a2a17da0
d97da3b6-f1f5-44dc-9826-00e899610d43	1da69e2a-851d-431c-94ea-93fa1722ec8c
d97da3b6-f1f5-44dc-9826-00e899610d43	32618d06-a19d-4136-ad7c-79cbb524aa2a
f8bed06d-9331-42cd-acd5-5fc7dd060576	02a432a3-7b4d-4911-ab1a-c9a39868a4ca
0f2dd4e0-1834-4473-8be0-55a056715089	c7701e90-2f37-45ff-83b0-16aeb994aad5
c7701e90-2f37-45ff-83b0-16aeb994aad5	4750e31d-f2f3-4409-9cb7-a943363b3102
0d4b49e5-0937-4822-afb7-d0bb4d20296c	58a1d8b2-e472-405b-ad39-0b843bffa8c3
5d073cb7-a36d-4e14-9d15-bd104bcca43f	50322ea8-7082-4254-abe7-26aba54be488
0f2dd4e0-1834-4473-8be0-55a056715089	0754fdba-2315-4f78-a586-fd8fb9184bd0
0f2dd4e0-1834-4473-8be0-55a056715089	8c512a26-4b35-4326-a5ac-ccf1cc3e7d5f
5d073cb7-a36d-4e14-9d15-bd104bcca43f	9feb4fab-c2dc-42dd-8c30-774f80df88c0
5d073cb7-a36d-4e14-9d15-bd104bcca43f	a0b2d961-71a0-4990-a8c2-cfb5572de8cb
5d073cb7-a36d-4e14-9d15-bd104bcca43f	70668dbd-da95-462b-81b2-8ce92b5e1700
5d073cb7-a36d-4e14-9d15-bd104bcca43f	5e29451e-b187-4a19-99a3-56c6bc216466
5d073cb7-a36d-4e14-9d15-bd104bcca43f	1d478edd-4633-4cf4-8594-532a18c6ee84
5d073cb7-a36d-4e14-9d15-bd104bcca43f	f3baa98d-d745-424f-872a-14e9344217ad
5d073cb7-a36d-4e14-9d15-bd104bcca43f	d45b1c34-d013-429b-a02e-158d9bed0ce4
5d073cb7-a36d-4e14-9d15-bd104bcca43f	5adc8e13-2cbb-469e-a2f9-4c40b5b31706
5d073cb7-a36d-4e14-9d15-bd104bcca43f	625c609c-ad09-4d98-afaa-3cd3e910c8f5
5d073cb7-a36d-4e14-9d15-bd104bcca43f	3222d370-538d-4350-96af-0be129bf1edb
5d073cb7-a36d-4e14-9d15-bd104bcca43f	d611a39c-01ed-4cfb-80bb-1b4b909febde
5d073cb7-a36d-4e14-9d15-bd104bcca43f	4ec65493-cf9a-46fc-85d3-4baff967957c
5d073cb7-a36d-4e14-9d15-bd104bcca43f	d6d39c3b-d102-4523-b02e-f81d3df8bc86
5d073cb7-a36d-4e14-9d15-bd104bcca43f	2e5ce3b1-240d-40f6-a6aa-7e28b187a3b7
5d073cb7-a36d-4e14-9d15-bd104bcca43f	742cbe81-7b3b-475d-b40b-aefc575046a4
5d073cb7-a36d-4e14-9d15-bd104bcca43f	fa92ccde-91e9-4ddb-bcd3-c682addaf536
5d073cb7-a36d-4e14-9d15-bd104bcca43f	9c3035f3-99b8-4e91-b57b-ca246adaf9a8
5e29451e-b187-4a19-99a3-56c6bc216466	742cbe81-7b3b-475d-b40b-aefc575046a4
70668dbd-da95-462b-81b2-8ce92b5e1700	2e5ce3b1-240d-40f6-a6aa-7e28b187a3b7
70668dbd-da95-462b-81b2-8ce92b5e1700	9c3035f3-99b8-4e91-b57b-ca246adaf9a8
febeb978-3d48-4794-8883-1163acb36c7c	90b32364-0ee7-485b-b992-78f3d87b20eb
febeb978-3d48-4794-8883-1163acb36c7c	939ac421-aa49-47fa-bf45-9b0a1c95344e
febeb978-3d48-4794-8883-1163acb36c7c	2eea98c1-808b-407b-af79-712d5b4b84a4
febeb978-3d48-4794-8883-1163acb36c7c	eef0d406-061c-4512-abce-380724a1dbb8
febeb978-3d48-4794-8883-1163acb36c7c	661e2a06-b2dd-4f97-83a2-fac26e75b7b3
febeb978-3d48-4794-8883-1163acb36c7c	aab41454-3102-42ed-852b-d815279caac8
febeb978-3d48-4794-8883-1163acb36c7c	ed82d01b-e6ed-4a44-aa3a-6043af581e9e
febeb978-3d48-4794-8883-1163acb36c7c	312f0d02-0b1d-4b98-a6d8-5acb7851ebb5
febeb978-3d48-4794-8883-1163acb36c7c	3c90cd38-3f9c-49d7-b4a6-e5287353c34c
febeb978-3d48-4794-8883-1163acb36c7c	476283c8-a187-4fca-b32f-9334475af627
febeb978-3d48-4794-8883-1163acb36c7c	75b215f1-e33e-42d6-9541-f70f2968a3d0
febeb978-3d48-4794-8883-1163acb36c7c	d41ed46e-0084-418f-a5e1-89ba0b442c4d
febeb978-3d48-4794-8883-1163acb36c7c	89b09e1b-2d50-4afb-9843-170accaa1e73
febeb978-3d48-4794-8883-1163acb36c7c	de915e80-6f07-4e65-975f-62750a4fe753
febeb978-3d48-4794-8883-1163acb36c7c	d1d057ca-36da-4a81-b2c2-d688bb3427be
febeb978-3d48-4794-8883-1163acb36c7c	7039b9c8-451f-462e-9abb-424467e7c367
febeb978-3d48-4794-8883-1163acb36c7c	80f92d30-7033-40fc-bbd6-9d5fb254c62d
2921b191-ba86-4827-8b6d-d0bbab82002f	fa7b529f-02da-4676-af07-c8a1ece08863
2eea98c1-808b-407b-af79-712d5b4b84a4	de915e80-6f07-4e65-975f-62750a4fe753
2eea98c1-808b-407b-af79-712d5b4b84a4	80f92d30-7033-40fc-bbd6-9d5fb254c62d
eef0d406-061c-4512-abce-380724a1dbb8	d1d057ca-36da-4a81-b2c2-d688bb3427be
2921b191-ba86-4827-8b6d-d0bbab82002f	b7f0d6f6-bd2e-4786-ac43-3d4444d44f49
b7f0d6f6-bd2e-4786-ac43-3d4444d44f49	085584b0-0522-4617-9e81-f6e408053f02
faf66f12-8d0e-4f17-907f-ed3c63915709	f1c5c6cc-1c29-409e-a098-2b33fb2772d5
5d073cb7-a36d-4e14-9d15-bd104bcca43f	954562bf-fdcd-4980-ab9a-96c129ddb538
febeb978-3d48-4794-8883-1163acb36c7c	d50f4759-5edf-4150-b307-a4eda22a88b8
2921b191-ba86-4827-8b6d-d0bbab82002f	3f628e2a-115a-44f2-bc25-a6c8854cd5fb
2921b191-ba86-4827-8b6d-d0bbab82002f	75abe5a8-ebf2-4eec-bcf3-1a41ed0933e6
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
852d5bd4-9314-430a-b51c-5ef08929eb62	\N	password	e7f62dc9-eb51-4c47-941c-a7d40d42c27d	1689258888948	\N	{"value":"pRfLR4M5X6vZGjvS7z1GZxqzWOINDLJCotn7nnou5LU=","salt":"i3kvoSptleOOb5RowL1U3Q==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
5a5afcf5-0358-4af4-9041-96295d28f5e5	\N	password	b6e9bfaf-9a36-483a-9c6d-cb1e39d2736b	1689262526930	My password	{"value":"4yZXaLDVhlPB/0MD7egKfccES8RWS/IiuqqkFoAFEtE=","salt":"0MHW6FE3L+y1W7oHUXGubA==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
5809b9d7-21a1-4aea-aee1-5e557813674e	\N	password	bc61c7f2-518f-4f33-8ec9-cbf74d3c30c5	1689262541394	My password	{"value":"OwI5VSGydNRsCut3wKG8npUr8gbQ1yEUlz7niJtTLL4=","salt":"4griS7lDes6Rml+FJJSEZw==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
b184d2a8-996f-496b-9485-d19e8bae39e1	\N	password	88994533-2f45-4ceb-8782-dcb8365e9f44	1693837319607	My password	{"value":"VrQf4CVhpDG6dMxmY5IepsiYP5qiq5sFldIqQxxd+uQ=","salt":"1SD2j2zI/7QOodzDfdbXqA==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2023-07-13 14:34:45.561137	1	EXECUTED	8:bda77d94bf90182a1e30c24f1c155ec7	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.20.0	\N	\N	9258884870
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2023-07-13 14:34:45.571464	2	MARK_RAN	8:1ecb330f30986693d1cba9ab579fa219	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.20.0	\N	\N	9258884870
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2023-07-13 14:34:45.62701	3	EXECUTED	8:cb7ace19bc6d959f305605d255d4c843	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.20.0	\N	\N	9258884870
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2023-07-13 14:34:45.630063	4	EXECUTED	8:80230013e961310e6872e871be424a63	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.20.0	\N	\N	9258884870
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2023-07-13 14:34:45.780507	5	EXECUTED	8:67f4c20929126adc0c8e9bf48279d244	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.20.0	\N	\N	9258884870
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2023-07-13 14:34:45.782027	6	MARK_RAN	8:7311018b0b8179ce14628ab412bb6783	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.20.0	\N	\N	9258884870
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2023-07-13 14:34:45.882424	7	EXECUTED	8:037ba1216c3640f8785ee6b8e7c8e3c1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.20.0	\N	\N	9258884870
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2023-07-13 14:34:45.884108	8	MARK_RAN	8:7fe6ffe4af4df289b3157de32c624263	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.20.0	\N	\N	9258884870
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2023-07-13 14:34:45.887155	9	EXECUTED	8:9c136bc3187083a98745c7d03bc8a303	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.20.0	\N	\N	9258884870
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2023-07-13 14:34:46.01031	10	EXECUTED	8:b5f09474dca81fb56a97cf5b6553d331	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.20.0	\N	\N	9258884870
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2023-07-13 14:34:46.067876	11	EXECUTED	8:ca924f31bd2a3b219fdcfe78c82dacf4	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.20.0	\N	\N	9258884870
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2023-07-13 14:34:46.068912	12	MARK_RAN	8:8acad7483e106416bcfa6f3b824a16cd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.20.0	\N	\N	9258884870
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2023-07-13 14:34:46.07819	13	EXECUTED	8:9b1266d17f4f87c78226f5055408fd5e	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.20.0	\N	\N	9258884870
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-07-13 14:34:46.10195	14	EXECUTED	8:d80ec4ab6dbfe573550ff72396c7e910	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.20.0	\N	\N	9258884870
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-07-13 14:34:46.102886	15	MARK_RAN	8:d86eb172171e7c20b9c849b584d147b2	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.20.0	\N	\N	9258884870
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-07-13 14:34:46.103952	16	MARK_RAN	8:5735f46f0fa60689deb0ecdc2a0dea22	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.20.0	\N	\N	9258884870
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-07-13 14:34:46.105182	17	EXECUTED	8:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.20.0	\N	\N	9258884870
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2023-07-13 14:34:46.157204	18	EXECUTED	8:5c1a8fd2014ac7fc43b90a700f117b23	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.20.0	\N	\N	9258884870
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2023-07-13 14:34:46.208539	19	EXECUTED	8:1f6c2c2dfc362aff4ed75b3f0ef6b331	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.20.0	\N	\N	9258884870
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2023-07-13 14:34:46.211411	20	EXECUTED	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.20.0	\N	\N	9258884870
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2023-07-13 14:34:46.212199	21	MARK_RAN	8:9eb2ee1fa8ad1c5e426421a6f8fdfa6a	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.20.0	\N	\N	9258884870
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2023-07-13 14:34:46.217761	22	MARK_RAN	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.20.0	\N	\N	9258884870
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2023-07-13 14:34:46.243097	23	EXECUTED	8:d9fa18ffa355320395b86270680dd4fe	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.20.0	\N	\N	9258884870
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2023-07-13 14:34:46.246261	24	EXECUTED	8:90cff506fedb06141ffc1c71c4a1214c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.20.0	\N	\N	9258884870
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2023-07-13 14:34:46.2473	25	MARK_RAN	8:11a788aed4961d6d29c427c063af828c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.20.0	\N	\N	9258884870
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2023-07-13 14:34:46.288695	26	EXECUTED	8:a4218e51e1faf380518cce2af5d39b43	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.20.0	\N	\N	9258884870
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2023-07-13 14:34:46.395395	27	EXECUTED	8:d9e9a1bfaa644da9952456050f07bbdc	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.20.0	\N	\N	9258884870
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2023-07-13 14:34:46.398149	28	EXECUTED	8:d1bf991a6163c0acbfe664b615314505	update tableName=RESOURCE_SERVER_POLICY		\N	4.20.0	\N	\N	9258884870
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2023-07-13 14:34:46.487298	29	EXECUTED	8:88a743a1e87ec5e30bf603da68058a8c	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.20.0	\N	\N	9258884870
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2023-07-13 14:34:46.514914	30	EXECUTED	8:c5517863c875d325dea463d00ec26d7a	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.20.0	\N	\N	9258884870
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2023-07-13 14:34:46.538911	31	EXECUTED	8:ada8b4833b74a498f376d7136bc7d327	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.20.0	\N	\N	9258884870
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2023-07-13 14:34:46.54255	32	EXECUTED	8:b9b73c8ea7299457f99fcbb825c263ba	customChange		\N	4.20.0	\N	\N	9258884870
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-07-13 14:34:46.545876	33	EXECUTED	8:07724333e625ccfcfc5adc63d57314f3	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.20.0	\N	\N	9258884870
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-07-13 14:34:46.546666	34	MARK_RAN	8:8b6fd445958882efe55deb26fc541a7b	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.20.0	\N	\N	9258884870
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-07-13 14:34:46.573683	35	EXECUTED	8:29b29cfebfd12600897680147277a9d7	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.20.0	\N	\N	9258884870
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2023-07-13 14:34:46.576001	36	EXECUTED	8:73ad77ca8fd0410c7f9f15a471fa52bc	addColumn tableName=REALM		\N	4.20.0	\N	\N	9258884870
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-07-13 14:34:46.582255	37	EXECUTED	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.20.0	\N	\N	9258884870
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2023-07-13 14:34:46.584275	38	EXECUTED	8:27180251182e6c31846c2ddab4bc5781	addColumn tableName=FED_USER_CONSENT		\N	4.20.0	\N	\N	9258884870
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2023-07-13 14:34:46.585923	39	EXECUTED	8:d56f201bfcfa7a1413eb3e9bc02978f9	addColumn tableName=IDENTITY_PROVIDER		\N	4.20.0	\N	\N	9258884870
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-07-13 14:34:46.586698	40	MARK_RAN	8:91f5522bf6afdc2077dfab57fbd3455c	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.20.0	\N	\N	9258884870
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-07-13 14:34:46.587609	41	MARK_RAN	8:0f01b554f256c22caeb7d8aee3a1cdc8	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.20.0	\N	\N	9258884870
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2023-07-13 14:34:46.592367	42	EXECUTED	8:ab91cf9cee415867ade0e2df9651a947	customChange		\N	4.20.0	\N	\N	9258884870
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-07-13 14:34:46.760096	43	EXECUTED	8:ceac9b1889e97d602caf373eadb0d4b7	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.20.0	\N	\N	9258884870
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2023-07-13 14:34:46.762523	44	EXECUTED	8:84b986e628fe8f7fd8fd3c275c5259f2	addColumn tableName=USER_ENTITY		\N	4.20.0	\N	\N	9258884870
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-07-13 14:34:46.764533	45	EXECUTED	8:a164ae073c56ffdbc98a615493609a52	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.20.0	\N	\N	9258884870
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-07-13 14:34:46.7692	46	EXECUTED	8:70a2b4f1f4bd4dbf487114bdb1810e64	customChange		\N	4.20.0	\N	\N	9258884870
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-07-13 14:34:46.769996	47	MARK_RAN	8:7be68b71d2f5b94b8df2e824f2860fa2	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.20.0	\N	\N	9258884870
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-07-13 14:34:46.822317	48	EXECUTED	8:bab7c631093c3861d6cf6144cd944982	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.20.0	\N	\N	9258884870
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-07-13 14:34:46.824829	49	EXECUTED	8:fa809ac11877d74d76fe40869916daad	addColumn tableName=REALM		\N	4.20.0	\N	\N	9258884870
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2023-07-13 14:34:46.873421	50	EXECUTED	8:fac23540a40208f5f5e326f6ceb4d291	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.20.0	\N	\N	9258884870
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2023-07-13 14:34:46.906706	51	EXECUTED	8:2612d1b8a97e2b5588c346e817307593	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.20.0	\N	\N	9258884870
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2023-07-13 14:34:46.908378	52	EXECUTED	8:9842f155c5db2206c88bcb5d1046e941	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.20.0	\N	\N	9258884870
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2023-07-13 14:34:46.910101	53	EXECUTED	8:2e12e06e45498406db72d5b3da5bbc76	update tableName=REALM		\N	4.20.0	\N	\N	9258884870
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2023-07-13 14:34:46.913631	54	EXECUTED	8:33560e7c7989250c40da3abdabdc75a4	update tableName=CLIENT		\N	4.20.0	\N	\N	9258884870
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-07-13 14:34:46.920826	55	EXECUTED	8:87a8d8542046817a9107c7eb9cbad1cd	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.20.0	\N	\N	9258884870
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-07-13 14:34:46.930105	56	EXECUTED	8:3ea08490a70215ed0088c273d776311e	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.20.0	\N	\N	9258884870
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-07-13 14:34:46.959052	57	EXECUTED	8:2d56697c8723d4592ab608ce14b6ed68	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.20.0	\N	\N	9258884870
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-07-13 14:34:47.079626	58	EXECUTED	8:3e423e249f6068ea2bbe48bf907f9d86	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.20.0	\N	\N	9258884870
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2023-07-13 14:34:47.11105	59	EXECUTED	8:15cabee5e5df0ff099510a0fc03e4103	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.20.0	\N	\N	9258884870
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2023-07-13 14:34:47.115601	60	EXECUTED	8:4b80200af916ac54d2ffbfc47918ab0e	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.20.0	\N	\N	9258884870
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2023-07-13 14:34:47.122717	61	EXECUTED	8:66564cd5e168045d52252c5027485bbb	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.20.0	\N	\N	9258884870
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2023-07-13 14:34:47.128295	62	EXECUTED	8:1c7064fafb030222be2bd16ccf690f6f	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.20.0	\N	\N	9258884870
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2023-07-13 14:34:47.130153	63	EXECUTED	8:2de18a0dce10cdda5c7e65c9b719b6e5	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.20.0	\N	\N	9258884870
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2023-07-13 14:34:47.132774	64	EXECUTED	8:03e413dd182dcbd5c57e41c34d0ef682	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.20.0	\N	\N	9258884870
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2023-07-13 14:34:47.136154	65	EXECUTED	8:d27b42bb2571c18fbe3fe4e4fb7582a7	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.20.0	\N	\N	9258884870
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2023-07-13 14:34:47.153879	66	EXECUTED	8:698baf84d9fd0027e9192717c2154fb8	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.20.0	\N	\N	9258884870
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2023-07-13 14:34:47.159466	67	EXECUTED	8:ced8822edf0f75ef26eb51582f9a821a	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.20.0	\N	\N	9258884870
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2023-07-13 14:34:47.162113	68	EXECUTED	8:f0abba004cf429e8afc43056df06487d	addColumn tableName=REALM		\N	4.20.0	\N	\N	9258884870
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2023-07-13 14:34:47.175074	69	EXECUTED	8:6662f8b0b611caa359fcf13bf63b4e24	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.20.0	\N	\N	9258884870
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2023-07-13 14:34:47.179387	70	EXECUTED	8:9e6b8009560f684250bdbdf97670d39e	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.20.0	\N	\N	9258884870
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2023-07-13 14:34:47.183434	71	EXECUTED	8:4223f561f3b8dc655846562b57bb502e	addColumn tableName=RESOURCE_SERVER		\N	4.20.0	\N	\N	9258884870
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-07-13 14:34:47.186515	72	EXECUTED	8:215a31c398b363ce383a2b301202f29e	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.20.0	\N	\N	9258884870
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-07-13 14:34:47.192974	73	EXECUTED	8:83f7a671792ca98b3cbd3a1a34862d3d	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.20.0	\N	\N	9258884870
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-07-13 14:34:47.193964	74	MARK_RAN	8:f58ad148698cf30707a6efbdf8061aa7	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.20.0	\N	\N	9258884870
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-07-13 14:34:47.225649	75	EXECUTED	8:79e4fd6c6442980e58d52ffc3ee7b19c	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.20.0	\N	\N	9258884870
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-07-13 14:34:47.232703	76	EXECUTED	8:87af6a1e6d241ca4b15801d1f86a297d	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.20.0	\N	\N	9258884870
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-07-13 14:34:47.234343	77	EXECUTED	8:b44f8d9b7b6ea455305a6d72a200ed15	addColumn tableName=CLIENT		\N	4.20.0	\N	\N	9258884870
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-07-13 14:34:47.235106	78	MARK_RAN	8:2d8ed5aaaeffd0cb004c046b4a903ac5	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.20.0	\N	\N	9258884870
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-07-13 14:34:47.251061	79	EXECUTED	8:e290c01fcbc275326c511633f6e2acde	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.20.0	\N	\N	9258884870
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-07-13 14:34:47.251915	80	MARK_RAN	8:c9db8784c33cea210872ac2d805439f8	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.20.0	\N	\N	9258884870
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-07-13 14:34:47.257164	81	EXECUTED	8:95b676ce8fc546a1fcfb4c92fae4add5	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.20.0	\N	\N	9258884870
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-07-13 14:34:47.25799	82	MARK_RAN	8:38a6b2a41f5651018b1aca93a41401e5	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.20.0	\N	\N	9258884870
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-07-13 14:34:47.262516	83	EXECUTED	8:3fb99bcad86a0229783123ac52f7609c	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.20.0	\N	\N	9258884870
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-07-13 14:34:47.26329	84	MARK_RAN	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.20.0	\N	\N	9258884870
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-07-13 14:34:47.267919	85	EXECUTED	8:ab4f863f39adafd4c862f7ec01890abc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.20.0	\N	\N	9258884870
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2023-07-13 14:34:47.269981	86	EXECUTED	8:13c419a0eb336e91ee3a3bf8fda6e2a7	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.20.0	\N	\N	9258884870
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2023-07-13 14:34:47.272443	87	EXECUTED	8:e3fb1e698e0471487f51af1ed80fe3ac	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.20.0	\N	\N	9258884870
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2023-07-13 14:34:47.2835	88	EXECUTED	8:babadb686aab7b56562817e60bf0abd0	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.20.0	\N	\N	9258884870
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-07-13 14:34:47.287642	89	EXECUTED	8:72d03345fda8e2f17093d08801947773	addColumn tableName=REALM; customChange		\N	4.20.0	\N	\N	9258884870
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-07-13 14:34:47.303596	90	EXECUTED	8:61c9233951bd96ffecd9ba75f7d978a4	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.20.0	\N	\N	9258884870
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-07-13 14:34:47.309434	91	EXECUTED	8:ea82e6ad945cec250af6372767b25525	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.20.0	\N	\N	9258884870
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-07-13 14:34:47.31254	92	EXECUTED	8:d3f4a33f41d960ddacd7e2ef30d126b3	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.20.0	\N	\N	9258884870
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-07-13 14:34:47.313283	93	MARK_RAN	8:1284a27fbd049d65831cb6fc07c8a783	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.20.0	\N	\N	9258884870
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-07-13 14:34:47.325588	94	EXECUTED	8:9d11b619db2ae27c25853b8a37cd0dea	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.20.0	\N	\N	9258884870
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-07-13 14:34:47.326609	95	MARK_RAN	8:3002bb3997451bb9e8bac5c5cd8d6327	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.20.0	\N	\N	9258884870
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-07-13 14:34:47.330468	96	EXECUTED	8:dfbee0d6237a23ef4ccbb7a4e063c163	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.20.0	\N	\N	9258884870
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-07-13 14:34:47.342498	97	EXECUTED	8:75f3e372df18d38c62734eebb986b960	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.20.0	\N	\N	9258884870
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-07-13 14:34:47.343473	98	MARK_RAN	8:7fee73eddf84a6035691512c85637eef	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.20.0	\N	\N	9258884870
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-07-13 14:34:47.358321	99	MARK_RAN	8:7a11134ab12820f999fbf3bb13c3adc8	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.20.0	\N	\N	9258884870
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-07-13 14:34:47.364299	100	EXECUTED	8:c0f6eaac1f3be773ffe54cb5b8482b70	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.20.0	\N	\N	9258884870
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-07-13 14:34:47.36515	101	MARK_RAN	8:18186f0008b86e0f0f49b0c4d0e842ac	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.20.0	\N	\N	9258884870
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-07-13 14:34:47.369721	102	EXECUTED	8:09c2780bcb23b310a7019d217dc7b433	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.20.0	\N	\N	9258884870
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-07-13 14:34:47.372929	103	EXECUTED	8:276a44955eab693c970a42880197fff2	customChange		\N	4.20.0	\N	\N	9258884870
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2023-07-13 14:34:47.377466	104	EXECUTED	8:ba8ee3b694d043f2bfc1a1079d0760d7	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.20.0	\N	\N	9258884870
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2023-07-13 14:34:47.382259	105	EXECUTED	8:5e06b1d75f5d17685485e610c2851b17	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.20.0	\N	\N	9258884870
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2023-07-13 14:34:47.386827	106	EXECUTED	8:4b80546c1dc550ac552ee7b24a4ab7c0	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.20.0	\N	\N	9258884870
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2023-07-13 14:34:47.389621	107	EXECUTED	8:af510cd1bb2ab6339c45372f3e491696	customChange		\N	4.20.0	\N	\N	9258884870
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2023-07-13 14:34:47.39572	108	EXECUTED	8:05c99fc610845ef66ee812b7921af0ef	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.20.0	\N	\N	9258884870
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2023-07-13 14:34:47.396666	109	MARK_RAN	8:314e803baf2f1ec315b3464e398b8247	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.20.0	\N	\N	9258884870
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2023-07-13 14:34:47.402658	110	EXECUTED	8:56e4677e7e12556f70b604c573840100	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.20.0	\N	\N	9258884870
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2023-07-13 14:34:47.405274	111	EXECUTED	8:8806cb33d2a546ce770384bf98cf6eac	customChange		\N	4.20.0	\N	\N	9258884870
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2023-07-13 14:34:47.467023	112	EXECUTED	8:fdb2924649d30555ab3a1744faba4928	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.20.0	\N	\N	9258884870
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2023-07-13 14:34:47.469415	113	MARK_RAN	8:1c96cc2b10903bd07a03670098d67fd6	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.20.0	\N	\N	9258884870
22.0.0-17484	keycloak	META-INF/jpa-changelog-22.0.0.xml	2023-07-13 14:34:47.473488	114	EXECUTED	8:4c3d4e8b142a66fcdf21b89a4dd33301	customChange		\N	4.20.0	\N	\N	9258884870
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
1cc45988-1774-48f1-af0c-82610082f679	abffa3df-9848-42b2-9cd8-b794d6276323	f
1cc45988-1774-48f1-af0c-82610082f679	92aa7bbc-57ee-4818-b099-31978b50fcb4	t
1cc45988-1774-48f1-af0c-82610082f679	1bf4f16b-ac24-4b8b-b37c-c3d1e8ea04dc	t
1cc45988-1774-48f1-af0c-82610082f679	c004f83e-0447-4b54-9a8e-86ce5bf31659	t
1cc45988-1774-48f1-af0c-82610082f679	6b166822-e30d-43f0-9b3f-3f9fe2e4b85d	f
1cc45988-1774-48f1-af0c-82610082f679	0d45615a-7d8a-4f38-9732-ac2ad00c4bd4	f
1cc45988-1774-48f1-af0c-82610082f679	730703e7-778f-413b-a5fb-c827bd1e40c6	t
1cc45988-1774-48f1-af0c-82610082f679	1a2033a7-da9c-4d84-b400-76335ece1b7d	t
1cc45988-1774-48f1-af0c-82610082f679	1e10e8f1-decd-4acf-90e9-b02ba945c11c	f
1cc45988-1774-48f1-af0c-82610082f679	622124d9-c441-4690-8c25-7e621871e502	t
fd31cefa-d2de-4b30-884e-96a0a709f62d	71cc9248-d579-4c0e-8663-a2656961ae1f	f
fd31cefa-d2de-4b30-884e-96a0a709f62d	16bb13ec-6d58-4ffa-8c7a-ac245578dfaf	t
fd31cefa-d2de-4b30-884e-96a0a709f62d	7fa04efb-e52a-40d9-9c91-5caee279c390	t
fd31cefa-d2de-4b30-884e-96a0a709f62d	53305b8b-f82e-4974-a0c8-0c119305275d	t
fd31cefa-d2de-4b30-884e-96a0a709f62d	4b0e37e8-57e4-4bb8-8634-f49ff60e1cbc	t
fd31cefa-d2de-4b30-884e-96a0a709f62d	689569d2-a88d-42c9-910a-b6d626dddf6e	f
fd31cefa-d2de-4b30-884e-96a0a709f62d	76459466-f04e-48c4-9264-e85d88f829f1	t
fd31cefa-d2de-4b30-884e-96a0a709f62d	4bdf1d1a-8eb1-491d-b08d-3f86451861d2	t
fd31cefa-d2de-4b30-884e-96a0a709f62d	832ed194-774b-46c3-8ef7-27abb084324d	t
fd31cefa-d2de-4b30-884e-96a0a709f62d	e398020c-1ec1-487e-9584-34a75459de0e	t
fd31cefa-d2de-4b30-884e-96a0a709f62d	1ab56eb4-8970-4b91-8807-45ee7e579c6f	t
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
3d29a620-0bba-4c3f-a769-6b4d5ce19e75	mapseh-client	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"http://localhost:3000/api/auth/callback/keycloak","code_id":"2dbe017d-6dcf-4df6-82cd-4061d0185d71","username":"kcadmin"}	user_not_found	172.19.0.1	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N	1689268012453	LOGIN_ERROR	\N
8d7cde32-25a0-4aae-a33c-513fdccdb974	\N	null	cookie_not_found	172.20.0.1	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N	1693845638141	LOGIN_ERROR	\N
ef08725a-755a-43e6-b925-ea792441c669	mapseh-client	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"http://localhost:3000/api/auth/callback/keycloak","code_id":"fd46e7ea-9391-42a7-87c6-05ccfe0b691a","username":"kcadmin"}	user_not_found	172.20.0.1	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N	1693928796096	LOGIN_ERROR	\N
76c7572d-b2cc-4b1c-82be-0ff45a337cf4	tyk-client	{"grant_type":"password"}	client_not_found	172.20.0.1	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N	1694013653210	LOGIN_ERROR	\N
d1c16a67-7221-45dd-b48c-b4be7adaf599	maps-eh	{"grant_type":"client_credentials"}	client_not_found	172.20.0.1	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N	1694016777727	CLIENT_LOGIN_ERROR	\N
5e7eeeba-29d1-4bb2-9b9d-dd1946ddfba1	mapseh-clienth	{"grant_type":"client_credentials"}	client_not_found	172.20.0.1	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N	1694016809907	CLIENT_LOGIN_ERROR	\N
6196d35a-e6e1-4e8e-b9b2-04448163f15b	test-client	{"grant_type":"client_credentials","client_auth_method":"client-secret","username":"service-account-test-client"}	invalid_request	172.20.0.1	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N	1694017770267	CLIENT_LOGIN_ERROR	a2bfd4e4-2668-49e3-a504-c1a707f23903
a1ab1b70-68b2-403a-b212-175e8302511c	test-client	{"grant_type":"client_credentials","client_auth_method":"client-secret","username":"service-account-test-client"}	invalid_request	172.20.0.1	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N	1694017785736	CLIENT_LOGIN_ERROR	a2bfd4e4-2668-49e3-a504-c1a707f23903
bb934587-a1af-4bce-83d6-ef475532ce85	maps-eh	{"grant_type":"client_credentials"}	client_not_found	172.20.0.1	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N	1694018260617	CLIENT_LOGIN_ERROR	\N
74380233-9fa4-4439-9f81-ade0f31170a9	admin-cli	{"auth_method":"openid-connect","grant_type":"password","client_auth_method":"client-secret","username":"kcadmin"}	invalid_user_credentials	172.20.0.1	1cc45988-1774-48f1-af0c-82610082f679	\N	1694018576284	LOGIN_ERROR	e7f62dc9-eb51-4c47-941c-a7d40d42c27d
c4f976a3-3612-4ff0-a356-f749ae912282	mapseh-client	{"auth_method":"openid-connect","grant_type":"password","client_auth_method":"client-secret"}	user_not_found	172.20.0.1	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N	1694077008919	LOGIN_ERROR	\N
977a0b3b-d34e-47ee-b6e9-97e761ced397	mapseh-client	{"grant_type":"client_credentials"}	invalid_client_credentials	172.20.0.1	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N	1694084423792	CLIENT_LOGIN_ERROR	\N
4d483530-970c-4db2-8abb-cbde08cbd816	mapseh-client	{"grant_type":"password"}	invalid_client_credentials	172.20.0.1	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N	1694084455322	LOGIN_ERROR	\N
28621eda-d359-4a7a-a5ad-b8cc7dc71441	mapseh-client	{"response_type":"code","redirect_uri":"http://localhost:3000/api/auth/callback/keycloak","response_mode":"query"}	invalid_request	172.20.0.1	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N	1695027092176	LOGIN_ERROR	\N
d86996dc-bad3-4554-adca-a9e931c4b149	mapseh-client	{"response_type":"code","redirect_uri":"http://localhost:3000/api/auth/callback/keycloak","response_mode":"query"}	invalid_request	172.20.0.1	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N	1695027188513	LOGIN_ERROR	\N
d27a2adb-dcfe-4bd8-afd0-8a0e25ee1f3f	mapseh-client	{"response_type":"code","redirect_uri":"http://localhost:3000/api/auth/callback/keycloak","response_mode":"query"}	invalid_request	172.20.0.1	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N	1695027188533	LOGIN_ERROR	\N
270a1cc8-f096-43cc-84c0-81d92f3a360c	mapseh-client	{"response_type":"code","redirect_uri":"http://localhost:3000/api/auth/callback/keycloak","response_mode":"query"}	invalid_request	172.20.0.1	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N	1695027188541	LOGIN_ERROR	\N
f95dc3a0-7d9c-4446-88b9-a1b59211e378	mapseh-client	{"response_type":"code","redirect_uri":"http://localhost:3000/api/auth/callback/keycloak","response_mode":"query"}	invalid_request	172.20.0.1	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N	1695029043213	LOGIN_ERROR	\N
7ec5f467-12db-47c6-a12c-3bb06fc92b83	mapseh-client	{"response_type":"code","redirect_uri":"http://localhost:3000/api/auth/callback/keycloak","response_mode":"query"}	invalid_request	172.20.0.1	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N	1695029069856	LOGIN_ERROR	\N
f919af01-7f63-4d57-b649-6feeb0657746	mapseh-client	{"response_type":"code","redirect_uri":"http://localhost:3000/api/auth/callback/keycloak","response_mode":"query"}	invalid_request	172.20.0.1	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N	1695029071040	LOGIN_ERROR	\N
a4732f4e-b514-4a8c-af88-92c00e18397d	mapseh-client	{"response_type":"code","redirect_uri":"http://localhost:3000/api/auth/callback/keycloak","response_mode":"query"}	invalid_request	172.20.0.1	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N	1695029238070	LOGIN_ERROR	\N
05ace3ce-844b-420e-acce-f41876ac3c30	mapseh-client	{"response_type":"code","redirect_uri":"http://localhost:3000/api/auth/callback/keycloak","response_mode":"query"}	invalid_request	172.20.0.1	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N	1695029266651	LOGIN_ERROR	\N
605bf843-d1e8-4467-8307-d427e89fddec	mapseh-client	{"response_type":"code","redirect_uri":"http://localhost:3000/api/auth/callback/keycloak","response_mode":"query"}	invalid_request	172.20.0.1	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N	1695029267827	LOGIN_ERROR	\N
664b120d-094b-44ef-bb67-1c9fafe77465	mapseh-client	{"response_type":"code","redirect_uri":"http://localhost:3000/api/auth/callback/keycloak","response_mode":"query"}	invalid_request	172.20.0.1	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N	1695029611319	LOGIN_ERROR	\N
ec7be426-f932-4827-9b58-1e33fba98855	mapseh-client	{"response_type":"code","redirect_uri":"http://localhost:3000/api/auth/callback/keycloak","response_mode":"query"}	invalid_request	172.20.0.1	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N	1695029611343	LOGIN_ERROR	\N
7002d380-d238-4b07-b34b-56e2c9a7e059	mapseh-client	{"response_type":"code","redirect_uri":"http://localhost:3000/api/auth/callback/keycloak","response_mode":"query"}	invalid_request	172.20.0.1	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N	1695029612485	LOGIN_ERROR	\N
e4ac7572-629b-4899-a847-d7e970f64283	mapseh-client	{"response_type":"code","redirect_uri":"http://localhost:3000/api/auth/callback/keycloak","response_mode":"query"}	invalid_request	172.20.0.1	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N	1695029612493	LOGIN_ERROR	\N
7129fa80-1795-40ae-b5ac-4b39c5831190	mapseh-client	{"response_type":"code","redirect_uri":"http://localhost:3000/api/auth/callback/keycloak","response_mode":"query"}	invalid_request	172.20.0.1	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N	1695029624427	LOGIN_ERROR	\N
63dd1405-856c-415c-ad71-45e06fb7176e	mapseh-client	{"response_type":"code","redirect_uri":"http://localhost:3000/api/auth/callback/keycloak","response_mode":"query"}	invalid_request	172.20.0.1	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N	1695029793993	LOGIN_ERROR	\N
990c4e77-8e3a-4156-847b-59a7edeb9373	\N	null	cookie_not_found	172.20.0.1	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N	1695029944413	LOGIN_ERROR	\N
244c27ab-8d1e-4617-8cde-47a49efced8a	mapseh-client	{"auth_method":"openid-connect","grant_type":"password","client_auth_method":"client-secret","username":"kcadmin"}	user_not_found	172.20.0.1	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N	1695058461482	LOGIN_ERROR	\N
26777c76-f3eb-4f49-bc4b-e3e86c174898	mapseh-client	{"auth_method":"openid-connect","grant_type":"password","client_auth_method":"client-secret","username":"kcadmin"}	user_not_found	172.20.0.1	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N	1695058470794	LOGIN_ERROR	\N
b59cb4b6-df96-4972-89da-c9897e0ec672	master	{"grant_type":"password"}	client_not_found	172.20.0.1	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N	1695058481717	LOGIN_ERROR	\N
970fe661-2e90-48ca-820f-72d4910dbec5	admin-cli	{"grant_type":"client_credentials","client_auth_method":"client-secret"}	invalid_client	172.20.0.1	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N	1695058673850	CLIENT_LOGIN_ERROR	\N
2cbe219c-7f0c-4453-8d30-0f082d6fb903	mapseh-client	{"grant_type":"client_credentials"}	invalid_client_credentials	172.20.0.1	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N	1695114225755	CLIENT_LOGIN_ERROR	\N
9021009d-2630-44d5-a2f1-6fd7c8df48b2	\N	{"grant_type":"client_credentials"}	client_not_found	172.20.0.1	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N	1695114260162	CLIENT_LOGIN_ERROR	\N
feba7d93-02d1-4332-a22e-0524cb59b70e	\N	{"grant_type":"client_credentials"}	client_not_found	172.20.0.1	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N	1695115369796	CLIENT_LOGIN_ERROR	\N
53ea0631-191d-4334-bac7-adbe07f4a54a	\N	{"grant_type":"client_credentials"}	client_not_found	172.20.0.1	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N	1695115458266	CLIENT_LOGIN_ERROR	\N
384b84ed-f302-4b40-8d9a-e244496d8940	\N	{"grant_type":"client_credentials"}	client_not_found	172.20.0.1	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N	1695115877197	CLIENT_LOGIN_ERROR	\N
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
3359778c-b9ee-4c8c-8232-31906cfd30d7	040226dd-69ce-4c4c-9908-baa131b50fcb
2a2068a7-6ed5-4b6c-af6f-bf3fe058de3c	13c5a252-369b-4213-8a83-dd381d658b73
2921b191-ba86-4827-8b6d-d0bbab82002f	ec05b00b-3d76-4879-9cbb-add9c8f82ae2
2921b191-ba86-4827-8b6d-d0bbab82002f	b385c45f-9aa3-4635-9950-87e1de5fd8f2
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
13c5a252-369b-4213-8a83-dd381d658b73	therapist	 	fd31cefa-d2de-4b30-884e-96a0a709f62d
040226dd-69ce-4c4c-9908-baa131b50fcb	patient	 	fd31cefa-d2de-4b30-884e-96a0a709f62d
ec05b00b-3d76-4879-9cbb-add9c8f82ae2	equipe1	 	fd31cefa-d2de-4b30-884e-96a0a709f62d
b385c45f-9aa3-4635-9950-87e1de5fd8f2	equipe2	 	fd31cefa-d2de-4b30-884e-96a0a709f62d
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
0f2dd4e0-1834-4473-8be0-55a056715089	1cc45988-1774-48f1-af0c-82610082f679	f	${role_default-roles}	default-roles-master	1cc45988-1774-48f1-af0c-82610082f679	\N	\N
5d073cb7-a36d-4e14-9d15-bd104bcca43f	1cc45988-1774-48f1-af0c-82610082f679	f	${role_admin}	admin	1cc45988-1774-48f1-af0c-82610082f679	\N	\N
bb82387b-3eca-4a05-8870-19c2c1021611	1cc45988-1774-48f1-af0c-82610082f679	f	${role_create-realm}	create-realm	1cc45988-1774-48f1-af0c-82610082f679	\N	\N
02031fb7-3358-4ce6-bc61-d69755536eba	461713e1-3a6d-44d1-af1f-051eae64b3a1	t	${role_create-client}	create-client	1cc45988-1774-48f1-af0c-82610082f679	461713e1-3a6d-44d1-af1f-051eae64b3a1	\N
d2780a7d-656d-4614-a14a-1194e75b9c08	461713e1-3a6d-44d1-af1f-051eae64b3a1	t	${role_view-realm}	view-realm	1cc45988-1774-48f1-af0c-82610082f679	461713e1-3a6d-44d1-af1f-051eae64b3a1	\N
d97da3b6-f1f5-44dc-9826-00e899610d43	461713e1-3a6d-44d1-af1f-051eae64b3a1	t	${role_view-users}	view-users	1cc45988-1774-48f1-af0c-82610082f679	461713e1-3a6d-44d1-af1f-051eae64b3a1	\N
f8bed06d-9331-42cd-acd5-5fc7dd060576	461713e1-3a6d-44d1-af1f-051eae64b3a1	t	${role_view-clients}	view-clients	1cc45988-1774-48f1-af0c-82610082f679	461713e1-3a6d-44d1-af1f-051eae64b3a1	\N
48c2c665-f1f5-431d-a39b-88a2797189a0	461713e1-3a6d-44d1-af1f-051eae64b3a1	t	${role_view-events}	view-events	1cc45988-1774-48f1-af0c-82610082f679	461713e1-3a6d-44d1-af1f-051eae64b3a1	\N
48d15bf6-46fb-423b-9bd0-f38da8038ba1	461713e1-3a6d-44d1-af1f-051eae64b3a1	t	${role_view-identity-providers}	view-identity-providers	1cc45988-1774-48f1-af0c-82610082f679	461713e1-3a6d-44d1-af1f-051eae64b3a1	\N
7693a5f3-37b9-4771-9008-e1905ef98e2e	461713e1-3a6d-44d1-af1f-051eae64b3a1	t	${role_view-authorization}	view-authorization	1cc45988-1774-48f1-af0c-82610082f679	461713e1-3a6d-44d1-af1f-051eae64b3a1	\N
adfa88ef-c678-4c69-a4e4-e3784ba9eefa	461713e1-3a6d-44d1-af1f-051eae64b3a1	t	${role_manage-realm}	manage-realm	1cc45988-1774-48f1-af0c-82610082f679	461713e1-3a6d-44d1-af1f-051eae64b3a1	\N
98128e9f-c55b-45a9-89e5-d4516f1a3ed7	461713e1-3a6d-44d1-af1f-051eae64b3a1	t	${role_manage-users}	manage-users	1cc45988-1774-48f1-af0c-82610082f679	461713e1-3a6d-44d1-af1f-051eae64b3a1	\N
ce5bfa23-eedd-4265-a99c-033cb83ec389	461713e1-3a6d-44d1-af1f-051eae64b3a1	t	${role_manage-clients}	manage-clients	1cc45988-1774-48f1-af0c-82610082f679	461713e1-3a6d-44d1-af1f-051eae64b3a1	\N
1e872217-29f2-49ff-8a29-a48bacb91f27	461713e1-3a6d-44d1-af1f-051eae64b3a1	t	${role_manage-events}	manage-events	1cc45988-1774-48f1-af0c-82610082f679	461713e1-3a6d-44d1-af1f-051eae64b3a1	\N
b95aca36-ddbf-4af8-8a6d-64eb912bca1e	461713e1-3a6d-44d1-af1f-051eae64b3a1	t	${role_manage-identity-providers}	manage-identity-providers	1cc45988-1774-48f1-af0c-82610082f679	461713e1-3a6d-44d1-af1f-051eae64b3a1	\N
86c37a24-7e07-42d9-acf8-26e8f8f9a600	461713e1-3a6d-44d1-af1f-051eae64b3a1	t	${role_manage-authorization}	manage-authorization	1cc45988-1774-48f1-af0c-82610082f679	461713e1-3a6d-44d1-af1f-051eae64b3a1	\N
1da69e2a-851d-431c-94ea-93fa1722ec8c	461713e1-3a6d-44d1-af1f-051eae64b3a1	t	${role_query-users}	query-users	1cc45988-1774-48f1-af0c-82610082f679	461713e1-3a6d-44d1-af1f-051eae64b3a1	\N
02a432a3-7b4d-4911-ab1a-c9a39868a4ca	461713e1-3a6d-44d1-af1f-051eae64b3a1	t	${role_query-clients}	query-clients	1cc45988-1774-48f1-af0c-82610082f679	461713e1-3a6d-44d1-af1f-051eae64b3a1	\N
d7629eaf-1174-4285-8bf6-dfd6c0e34068	461713e1-3a6d-44d1-af1f-051eae64b3a1	t	${role_query-realms}	query-realms	1cc45988-1774-48f1-af0c-82610082f679	461713e1-3a6d-44d1-af1f-051eae64b3a1	\N
32618d06-a19d-4136-ad7c-79cbb524aa2a	461713e1-3a6d-44d1-af1f-051eae64b3a1	t	${role_query-groups}	query-groups	1cc45988-1774-48f1-af0c-82610082f679	461713e1-3a6d-44d1-af1f-051eae64b3a1	\N
291b1935-dcce-49c6-9ac9-2af6a2a17da0	973ab1c7-211d-4310-8bc8-f2a30f74d7a6	t	${role_view-profile}	view-profile	1cc45988-1774-48f1-af0c-82610082f679	973ab1c7-211d-4310-8bc8-f2a30f74d7a6	\N
c7701e90-2f37-45ff-83b0-16aeb994aad5	973ab1c7-211d-4310-8bc8-f2a30f74d7a6	t	${role_manage-account}	manage-account	1cc45988-1774-48f1-af0c-82610082f679	973ab1c7-211d-4310-8bc8-f2a30f74d7a6	\N
4750e31d-f2f3-4409-9cb7-a943363b3102	973ab1c7-211d-4310-8bc8-f2a30f74d7a6	t	${role_manage-account-links}	manage-account-links	1cc45988-1774-48f1-af0c-82610082f679	973ab1c7-211d-4310-8bc8-f2a30f74d7a6	\N
2dfafffe-9958-45eb-805b-d0e82909e0d1	973ab1c7-211d-4310-8bc8-f2a30f74d7a6	t	${role_view-applications}	view-applications	1cc45988-1774-48f1-af0c-82610082f679	973ab1c7-211d-4310-8bc8-f2a30f74d7a6	\N
58a1d8b2-e472-405b-ad39-0b843bffa8c3	973ab1c7-211d-4310-8bc8-f2a30f74d7a6	t	${role_view-consent}	view-consent	1cc45988-1774-48f1-af0c-82610082f679	973ab1c7-211d-4310-8bc8-f2a30f74d7a6	\N
0d4b49e5-0937-4822-afb7-d0bb4d20296c	973ab1c7-211d-4310-8bc8-f2a30f74d7a6	t	${role_manage-consent}	manage-consent	1cc45988-1774-48f1-af0c-82610082f679	973ab1c7-211d-4310-8bc8-f2a30f74d7a6	\N
841118fa-b9a0-409b-82a2-b26b89e6de26	973ab1c7-211d-4310-8bc8-f2a30f74d7a6	t	${role_view-groups}	view-groups	1cc45988-1774-48f1-af0c-82610082f679	973ab1c7-211d-4310-8bc8-f2a30f74d7a6	\N
8eff0c3e-97d9-4fab-b47e-df0441ade69f	973ab1c7-211d-4310-8bc8-f2a30f74d7a6	t	${role_delete-account}	delete-account	1cc45988-1774-48f1-af0c-82610082f679	973ab1c7-211d-4310-8bc8-f2a30f74d7a6	\N
f666456a-79ee-4c81-8dab-ff295e8a77c0	6e06434d-8058-4631-b93f-d97693c4527e	t	${role_read-token}	read-token	1cc45988-1774-48f1-af0c-82610082f679	6e06434d-8058-4631-b93f-d97693c4527e	\N
50322ea8-7082-4254-abe7-26aba54be488	461713e1-3a6d-44d1-af1f-051eae64b3a1	t	${role_impersonation}	impersonation	1cc45988-1774-48f1-af0c-82610082f679	461713e1-3a6d-44d1-af1f-051eae64b3a1	\N
0754fdba-2315-4f78-a586-fd8fb9184bd0	1cc45988-1774-48f1-af0c-82610082f679	f	${role_offline-access}	offline_access	1cc45988-1774-48f1-af0c-82610082f679	\N	\N
8c512a26-4b35-4326-a5ac-ccf1cc3e7d5f	1cc45988-1774-48f1-af0c-82610082f679	f	${role_uma_authorization}	uma_authorization	1cc45988-1774-48f1-af0c-82610082f679	\N	\N
2921b191-ba86-4827-8b6d-d0bbab82002f	fd31cefa-d2de-4b30-884e-96a0a709f62d	f	${role_default-roles}	default-roles-maps-eh	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N	\N
9feb4fab-c2dc-42dd-8c30-774f80df88c0	84f88319-ae5f-43af-8082-b672daef927d	t	${role_create-client}	create-client	1cc45988-1774-48f1-af0c-82610082f679	84f88319-ae5f-43af-8082-b672daef927d	\N
a0b2d961-71a0-4990-a8c2-cfb5572de8cb	84f88319-ae5f-43af-8082-b672daef927d	t	${role_view-realm}	view-realm	1cc45988-1774-48f1-af0c-82610082f679	84f88319-ae5f-43af-8082-b672daef927d	\N
70668dbd-da95-462b-81b2-8ce92b5e1700	84f88319-ae5f-43af-8082-b672daef927d	t	${role_view-users}	view-users	1cc45988-1774-48f1-af0c-82610082f679	84f88319-ae5f-43af-8082-b672daef927d	\N
5e29451e-b187-4a19-99a3-56c6bc216466	84f88319-ae5f-43af-8082-b672daef927d	t	${role_view-clients}	view-clients	1cc45988-1774-48f1-af0c-82610082f679	84f88319-ae5f-43af-8082-b672daef927d	\N
1d478edd-4633-4cf4-8594-532a18c6ee84	84f88319-ae5f-43af-8082-b672daef927d	t	${role_view-events}	view-events	1cc45988-1774-48f1-af0c-82610082f679	84f88319-ae5f-43af-8082-b672daef927d	\N
f3baa98d-d745-424f-872a-14e9344217ad	84f88319-ae5f-43af-8082-b672daef927d	t	${role_view-identity-providers}	view-identity-providers	1cc45988-1774-48f1-af0c-82610082f679	84f88319-ae5f-43af-8082-b672daef927d	\N
d45b1c34-d013-429b-a02e-158d9bed0ce4	84f88319-ae5f-43af-8082-b672daef927d	t	${role_view-authorization}	view-authorization	1cc45988-1774-48f1-af0c-82610082f679	84f88319-ae5f-43af-8082-b672daef927d	\N
5adc8e13-2cbb-469e-a2f9-4c40b5b31706	84f88319-ae5f-43af-8082-b672daef927d	t	${role_manage-realm}	manage-realm	1cc45988-1774-48f1-af0c-82610082f679	84f88319-ae5f-43af-8082-b672daef927d	\N
625c609c-ad09-4d98-afaa-3cd3e910c8f5	84f88319-ae5f-43af-8082-b672daef927d	t	${role_manage-users}	manage-users	1cc45988-1774-48f1-af0c-82610082f679	84f88319-ae5f-43af-8082-b672daef927d	\N
3222d370-538d-4350-96af-0be129bf1edb	84f88319-ae5f-43af-8082-b672daef927d	t	${role_manage-clients}	manage-clients	1cc45988-1774-48f1-af0c-82610082f679	84f88319-ae5f-43af-8082-b672daef927d	\N
d611a39c-01ed-4cfb-80bb-1b4b909febde	84f88319-ae5f-43af-8082-b672daef927d	t	${role_manage-events}	manage-events	1cc45988-1774-48f1-af0c-82610082f679	84f88319-ae5f-43af-8082-b672daef927d	\N
4ec65493-cf9a-46fc-85d3-4baff967957c	84f88319-ae5f-43af-8082-b672daef927d	t	${role_manage-identity-providers}	manage-identity-providers	1cc45988-1774-48f1-af0c-82610082f679	84f88319-ae5f-43af-8082-b672daef927d	\N
d6d39c3b-d102-4523-b02e-f81d3df8bc86	84f88319-ae5f-43af-8082-b672daef927d	t	${role_manage-authorization}	manage-authorization	1cc45988-1774-48f1-af0c-82610082f679	84f88319-ae5f-43af-8082-b672daef927d	\N
2e5ce3b1-240d-40f6-a6aa-7e28b187a3b7	84f88319-ae5f-43af-8082-b672daef927d	t	${role_query-users}	query-users	1cc45988-1774-48f1-af0c-82610082f679	84f88319-ae5f-43af-8082-b672daef927d	\N
742cbe81-7b3b-475d-b40b-aefc575046a4	84f88319-ae5f-43af-8082-b672daef927d	t	${role_query-clients}	query-clients	1cc45988-1774-48f1-af0c-82610082f679	84f88319-ae5f-43af-8082-b672daef927d	\N
fa92ccde-91e9-4ddb-bcd3-c682addaf536	84f88319-ae5f-43af-8082-b672daef927d	t	${role_query-realms}	query-realms	1cc45988-1774-48f1-af0c-82610082f679	84f88319-ae5f-43af-8082-b672daef927d	\N
9c3035f3-99b8-4e91-b57b-ca246adaf9a8	84f88319-ae5f-43af-8082-b672daef927d	t	${role_query-groups}	query-groups	1cc45988-1774-48f1-af0c-82610082f679	84f88319-ae5f-43af-8082-b672daef927d	\N
febeb978-3d48-4794-8883-1163acb36c7c	7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	t	${role_realm-admin}	realm-admin	fd31cefa-d2de-4b30-884e-96a0a709f62d	7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	\N
90b32364-0ee7-485b-b992-78f3d87b20eb	7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	t	${role_create-client}	create-client	fd31cefa-d2de-4b30-884e-96a0a709f62d	7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	\N
939ac421-aa49-47fa-bf45-9b0a1c95344e	7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	t	${role_view-realm}	view-realm	fd31cefa-d2de-4b30-884e-96a0a709f62d	7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	\N
2eea98c1-808b-407b-af79-712d5b4b84a4	7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	t	${role_view-users}	view-users	fd31cefa-d2de-4b30-884e-96a0a709f62d	7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	\N
eef0d406-061c-4512-abce-380724a1dbb8	7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	t	${role_view-clients}	view-clients	fd31cefa-d2de-4b30-884e-96a0a709f62d	7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	\N
661e2a06-b2dd-4f97-83a2-fac26e75b7b3	7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	t	${role_view-events}	view-events	fd31cefa-d2de-4b30-884e-96a0a709f62d	7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	\N
aab41454-3102-42ed-852b-d815279caac8	7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	t	${role_view-identity-providers}	view-identity-providers	fd31cefa-d2de-4b30-884e-96a0a709f62d	7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	\N
ed82d01b-e6ed-4a44-aa3a-6043af581e9e	7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	t	${role_view-authorization}	view-authorization	fd31cefa-d2de-4b30-884e-96a0a709f62d	7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	\N
312f0d02-0b1d-4b98-a6d8-5acb7851ebb5	7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	t	${role_manage-realm}	manage-realm	fd31cefa-d2de-4b30-884e-96a0a709f62d	7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	\N
3c90cd38-3f9c-49d7-b4a6-e5287353c34c	7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	t	${role_manage-users}	manage-users	fd31cefa-d2de-4b30-884e-96a0a709f62d	7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	\N
476283c8-a187-4fca-b32f-9334475af627	7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	t	${role_manage-clients}	manage-clients	fd31cefa-d2de-4b30-884e-96a0a709f62d	7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	\N
75b215f1-e33e-42d6-9541-f70f2968a3d0	7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	t	${role_manage-events}	manage-events	fd31cefa-d2de-4b30-884e-96a0a709f62d	7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	\N
d41ed46e-0084-418f-a5e1-89ba0b442c4d	7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	t	${role_manage-identity-providers}	manage-identity-providers	fd31cefa-d2de-4b30-884e-96a0a709f62d	7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	\N
89b09e1b-2d50-4afb-9843-170accaa1e73	7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	t	${role_manage-authorization}	manage-authorization	fd31cefa-d2de-4b30-884e-96a0a709f62d	7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	\N
de915e80-6f07-4e65-975f-62750a4fe753	7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	t	${role_query-users}	query-users	fd31cefa-d2de-4b30-884e-96a0a709f62d	7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	\N
d1d057ca-36da-4a81-b2c2-d688bb3427be	7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	t	${role_query-clients}	query-clients	fd31cefa-d2de-4b30-884e-96a0a709f62d	7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	\N
7039b9c8-451f-462e-9abb-424467e7c367	7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	t	${role_query-realms}	query-realms	fd31cefa-d2de-4b30-884e-96a0a709f62d	7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	\N
80f92d30-7033-40fc-bbd6-9d5fb254c62d	7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	t	${role_query-groups}	query-groups	fd31cefa-d2de-4b30-884e-96a0a709f62d	7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	\N
fa7b529f-02da-4676-af07-c8a1ece08863	55f49bf2-eaeb-4533-975d-9a07d5d20835	t	${role_view-profile}	view-profile	fd31cefa-d2de-4b30-884e-96a0a709f62d	55f49bf2-eaeb-4533-975d-9a07d5d20835	\N
b7f0d6f6-bd2e-4786-ac43-3d4444d44f49	55f49bf2-eaeb-4533-975d-9a07d5d20835	t	${role_manage-account}	manage-account	fd31cefa-d2de-4b30-884e-96a0a709f62d	55f49bf2-eaeb-4533-975d-9a07d5d20835	\N
085584b0-0522-4617-9e81-f6e408053f02	55f49bf2-eaeb-4533-975d-9a07d5d20835	t	${role_manage-account-links}	manage-account-links	fd31cefa-d2de-4b30-884e-96a0a709f62d	55f49bf2-eaeb-4533-975d-9a07d5d20835	\N
f92d6e4f-73dc-44d2-b445-84060914ca53	55f49bf2-eaeb-4533-975d-9a07d5d20835	t	${role_view-applications}	view-applications	fd31cefa-d2de-4b30-884e-96a0a709f62d	55f49bf2-eaeb-4533-975d-9a07d5d20835	\N
f1c5c6cc-1c29-409e-a098-2b33fb2772d5	55f49bf2-eaeb-4533-975d-9a07d5d20835	t	${role_view-consent}	view-consent	fd31cefa-d2de-4b30-884e-96a0a709f62d	55f49bf2-eaeb-4533-975d-9a07d5d20835	\N
faf66f12-8d0e-4f17-907f-ed3c63915709	55f49bf2-eaeb-4533-975d-9a07d5d20835	t	${role_manage-consent}	manage-consent	fd31cefa-d2de-4b30-884e-96a0a709f62d	55f49bf2-eaeb-4533-975d-9a07d5d20835	\N
546e7fda-5f50-467b-93f4-3590d6ecf010	55f49bf2-eaeb-4533-975d-9a07d5d20835	t	${role_view-groups}	view-groups	fd31cefa-d2de-4b30-884e-96a0a709f62d	55f49bf2-eaeb-4533-975d-9a07d5d20835	\N
2696bcf6-91ea-48c2-b99e-43eff3e6a5c3	55f49bf2-eaeb-4533-975d-9a07d5d20835	t	${role_delete-account}	delete-account	fd31cefa-d2de-4b30-884e-96a0a709f62d	55f49bf2-eaeb-4533-975d-9a07d5d20835	\N
954562bf-fdcd-4980-ab9a-96c129ddb538	84f88319-ae5f-43af-8082-b672daef927d	t	${role_impersonation}	impersonation	1cc45988-1774-48f1-af0c-82610082f679	84f88319-ae5f-43af-8082-b672daef927d	\N
d50f4759-5edf-4150-b307-a4eda22a88b8	7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	t	${role_impersonation}	impersonation	fd31cefa-d2de-4b30-884e-96a0a709f62d	7c5484d2-47bd-48d6-80b3-fd34bf0fe6ff	\N
14a3aee6-a288-4cc1-b395-3c3f6d604daa	f1a52f57-a2b2-48cf-a798-f4855efd1bbc	t	${role_read-token}	read-token	fd31cefa-d2de-4b30-884e-96a0a709f62d	f1a52f57-a2b2-48cf-a798-f4855efd1bbc	\N
3f628e2a-115a-44f2-bc25-a6c8854cd5fb	fd31cefa-d2de-4b30-884e-96a0a709f62d	f	${role_offline-access}	offline_access	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N	\N
75abe5a8-ebf2-4eec-bcf3-1a41ed0933e6	fd31cefa-d2de-4b30-884e-96a0a709f62d	f	${role_uma_authorization}	uma_authorization	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N	\N
2a2068a7-6ed5-4b6c-af6f-bf3fe058de3c	fd31cefa-d2de-4b30-884e-96a0a709f62d	f		therapist	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N	\N
77453a93-79c0-422b-9e82-77a382ebb647	47820472-954a-4742-9cb3-cf82d38e5190	t	\N	uma_protection	fd31cefa-d2de-4b30-884e-96a0a709f62d	47820472-954a-4742-9cb3-cf82d38e5190	\N
3359778c-b9ee-4c8c-8232-31906cfd30d7	fd31cefa-d2de-4b30-884e-96a0a709f62d	f		patient	fd31cefa-d2de-4b30-884e-96a0a709f62d	\N	\N
c2dfadd0-4aca-4437-95b9-3815f11c11b5	9d270c10-830e-45fa-ac7d-f919ab5b73cd	t	\N	uma_protection	fd31cefa-d2de-4b30-884e-96a0a709f62d	9d270c10-830e-45fa-ac7d-f919ab5b73cd	\N
4767ae6d-55df-4dd1-9148-682006e2af6c	a54d40d9-eed6-4b4f-bc19-4b3c57f666b9	t	\N	uma_protection	1cc45988-1774-48f1-af0c-82610082f679	a54d40d9-eed6-4b4f-bc19-4b3c57f666b9	\N
cd2e4928-8687-40fe-8a82-793b1f7883a8	7515e33c-65b7-4518-ad98-3711bbbc8f9c	t	\N	uma_protection	fd31cefa-d2de-4b30-884e-96a0a709f62d	7515e33c-65b7-4518-ad98-3711bbbc8f9c	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.migration_model (id, version, update_time) FROM stdin;
nor51	22.0.0	1689258887
x9y0j	22.0.1	1690296582
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
84e17510-6ac2-43d7-9665-fd37ca010d1f	code	// by default, grants any permission associated with this policy\n$evaluation.grant();\n
87879993-638f-4d29-8c49-03db731c9c55	defaultResourceType	urn:test-client:resources:default
f3dd65aa-ae61-4c95-bd19-771574c86113	code	// by default, grants any permission associated with this policy\n$evaluation.grant();\n
260d3120-2d37-479f-aacf-c8e0d2b07831	defaultResourceType	urn:admin-cli:resources:default
4c6899c2-b082-4990-a1fd-378fe60807c6	defaultResourceType	
aeff6316-09a6-42fe-8c34-f59cc2ae1c3c	groupsClaim	
aeff6316-09a6-42fe-8c34-f59cc2ae1c3c	groups	[{"id":"ec05b00b-3d76-4879-9cbb-add9c8f82ae2","extendChildren":false}]
2eb3054a-2aaa-4564-9534-de0406e0a980	groups	[{"id":"b385c45f-9aa3-4635-9950-87e1de5fd8f2","extendChildren":false}]
2eb3054a-2aaa-4564-9534-de0406e0a980	groupsClaim	
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
9ee91e77-2d7c-48f5-97d1-708f67c9814a	audience resolve	openid-connect	oidc-audience-resolve-mapper	d6e31b97-3056-4faf-9919-93710213550f	\N
fd6ff1a5-e0ad-4b79-911b-2348ef85afca	locale	openid-connect	oidc-usermodel-attribute-mapper	93129fbc-1e55-4d70-9c6c-a2e09e74066f	\N
29a5cec6-3474-4a68-9769-4b5f17dbb81a	role list	saml	saml-role-list-mapper	\N	92aa7bbc-57ee-4818-b099-31978b50fcb4
27e9342b-0c8f-449c-9260-761faf932bf9	full name	openid-connect	oidc-full-name-mapper	\N	1bf4f16b-ac24-4b8b-b37c-c3d1e8ea04dc
bf8b84fb-28b2-4687-8a03-5d6f96204b26	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	1bf4f16b-ac24-4b8b-b37c-c3d1e8ea04dc
3be67ac3-5c24-49c9-a54b-a6801de5dc0c	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	1bf4f16b-ac24-4b8b-b37c-c3d1e8ea04dc
94b8d993-7603-4178-8f0f-bc697f57b469	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	1bf4f16b-ac24-4b8b-b37c-c3d1e8ea04dc
84ba7c54-9d45-46c9-aab5-cc2594357853	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	1bf4f16b-ac24-4b8b-b37c-c3d1e8ea04dc
9675c8b9-d66a-43cf-aacb-82c197e4f318	username	openid-connect	oidc-usermodel-attribute-mapper	\N	1bf4f16b-ac24-4b8b-b37c-c3d1e8ea04dc
765df13b-4805-46f8-b069-b2bea0bf5d3c	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	1bf4f16b-ac24-4b8b-b37c-c3d1e8ea04dc
a96dbf8a-275b-4b50-87a1-e7743b1d2e29	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	1bf4f16b-ac24-4b8b-b37c-c3d1e8ea04dc
0483d5af-fdb5-4222-bb23-702454a73a8b	website	openid-connect	oidc-usermodel-attribute-mapper	\N	1bf4f16b-ac24-4b8b-b37c-c3d1e8ea04dc
db3da741-28a5-4ba9-9833-6f66d59120f6	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	1bf4f16b-ac24-4b8b-b37c-c3d1e8ea04dc
9474f34e-784c-4bdf-a287-65d1303a6813	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	1bf4f16b-ac24-4b8b-b37c-c3d1e8ea04dc
0ff6adf9-1e73-4150-87fe-cc5af46a7103	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	1bf4f16b-ac24-4b8b-b37c-c3d1e8ea04dc
018c6e2c-8153-43de-95dd-dcef6f4ad83c	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	1bf4f16b-ac24-4b8b-b37c-c3d1e8ea04dc
8d9ae76a-a48c-44a4-a69b-7cd8720406d9	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	1bf4f16b-ac24-4b8b-b37c-c3d1e8ea04dc
1259d3c1-eed2-4ea6-a16e-a313b4e3cc01	email	openid-connect	oidc-usermodel-attribute-mapper	\N	c004f83e-0447-4b54-9a8e-86ce5bf31659
0810a475-5d71-442b-bedc-0e962451825b	email verified	openid-connect	oidc-usermodel-property-mapper	\N	c004f83e-0447-4b54-9a8e-86ce5bf31659
65c62a75-506b-4af2-8e49-f8b59d19dee4	address	openid-connect	oidc-address-mapper	\N	6b166822-e30d-43f0-9b3f-3f9fe2e4b85d
9b1ce6de-f13a-4f19-b3f0-3370aec09f3f	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	0d45615a-7d8a-4f38-9732-ac2ad00c4bd4
501e9839-1e76-4ecd-bdfe-cc2f2e0ea9d8	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	0d45615a-7d8a-4f38-9732-ac2ad00c4bd4
df490c0d-0e8c-4de8-b2e2-624d385074f7	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	730703e7-778f-413b-a5fb-c827bd1e40c6
ff39e4f0-8261-44f6-ad97-2cb050789944	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	730703e7-778f-413b-a5fb-c827bd1e40c6
f215ebee-b84a-4d4a-b2f7-a8a26a553784	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	730703e7-778f-413b-a5fb-c827bd1e40c6
99476364-26d4-4ab5-a826-4c506c87df0e	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	1a2033a7-da9c-4d84-b400-76335ece1b7d
2b6d114c-8924-4117-ac20-afca7416a9f9	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	1e10e8f1-decd-4acf-90e9-b02ba945c11c
554f7b05-06e9-428a-a108-1cd0168c4c83	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	1e10e8f1-decd-4acf-90e9-b02ba945c11c
11320ecc-5ac3-4c19-94ef-bade7e0c1f33	acr loa level	openid-connect	oidc-acr-mapper	\N	622124d9-c441-4690-8c25-7e621871e502
c2788970-74f8-455d-ab94-896428f88246	audience resolve	openid-connect	oidc-audience-resolve-mapper	a3282fc4-8a2a-45da-a49f-7bfa42d3a853	\N
5613a598-7d3d-4176-be5c-bb396694b5c6	role list	saml	saml-role-list-mapper	\N	16bb13ec-6d58-4ffa-8c7a-ac245578dfaf
62734e87-07c7-4a98-aba3-f02a405ca514	full name	openid-connect	oidc-full-name-mapper	\N	7fa04efb-e52a-40d9-9c91-5caee279c390
8b937f0e-6959-4402-81c4-dcb6414a4904	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	7fa04efb-e52a-40d9-9c91-5caee279c390
0420a95e-604b-4ec6-b7ce-d5e399d6b93b	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	7fa04efb-e52a-40d9-9c91-5caee279c390
8e5183d0-d4c5-4365-81b3-c35ed38bff25	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	7fa04efb-e52a-40d9-9c91-5caee279c390
21f35fec-91d8-4b83-8c49-c3b3f4d9899e	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	7fa04efb-e52a-40d9-9c91-5caee279c390
35e63368-184e-4d6e-a7e4-1452521865d1	username	openid-connect	oidc-usermodel-attribute-mapper	\N	7fa04efb-e52a-40d9-9c91-5caee279c390
ab8bd18a-a33f-4090-9ccf-718cd9cfd06f	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	7fa04efb-e52a-40d9-9c91-5caee279c390
fcdd02eb-7e29-468d-aa53-8e6a76f8efa6	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	7fa04efb-e52a-40d9-9c91-5caee279c390
19d34388-32c8-4300-836a-e1baf49d776a	website	openid-connect	oidc-usermodel-attribute-mapper	\N	7fa04efb-e52a-40d9-9c91-5caee279c390
371d1d57-c053-4373-9dfb-d910bb9d6ef9	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	7fa04efb-e52a-40d9-9c91-5caee279c390
8ca3714f-8e98-4b9f-8b67-0e2c9f0bd978	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	7fa04efb-e52a-40d9-9c91-5caee279c390
39d4f92a-b645-4903-8fa2-6f86e352442c	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	7fa04efb-e52a-40d9-9c91-5caee279c390
2dc5d934-02e9-41d2-ba79-dd9f06958d48	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	7fa04efb-e52a-40d9-9c91-5caee279c390
750f0f28-7c6e-4125-9d03-1d3c19ee47e3	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	7fa04efb-e52a-40d9-9c91-5caee279c390
ca421f81-f3ff-47ff-8fe1-b8261ede459e	email	openid-connect	oidc-usermodel-attribute-mapper	\N	53305b8b-f82e-4974-a0c8-0c119305275d
fdf9fc8c-3f92-4c78-bc08-090bf832ef9d	email verified	openid-connect	oidc-usermodel-property-mapper	\N	53305b8b-f82e-4974-a0c8-0c119305275d
4ed62f97-e548-4adc-8669-a344c97df41a	address	openid-connect	oidc-address-mapper	\N	832ed194-774b-46c3-8ef7-27abb084324d
8e5289f1-d0d6-4337-ac51-f95ba93b157f	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	4bdf1d1a-8eb1-491d-b08d-3f86451861d2
32c5acf3-f5b3-461d-930d-d55f838923c2	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	4bdf1d1a-8eb1-491d-b08d-3f86451861d2
0723c60f-f526-45fd-984f-e537ba6344c1	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	e398020c-1ec1-487e-9584-34a75459de0e
9f9963a8-ed1c-4268-891f-c1904ed33a05	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	e398020c-1ec1-487e-9584-34a75459de0e
d6b531fb-76e2-4090-8959-f9833ba5f03e	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	e398020c-1ec1-487e-9584-34a75459de0e
243eee8a-f855-49dd-bfd7-3f8698915f94	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	4b0e37e8-57e4-4bb8-8634-f49ff60e1cbc
8e99c8e6-7b4f-4105-a2f5-2472cb9503ff	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	689569d2-a88d-42c9-910a-b6d626dddf6e
ac599866-6e4f-42f2-a585-d66ca9aa473a	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	689569d2-a88d-42c9-910a-b6d626dddf6e
bd3cf0d1-6f42-4dd0-9a7c-286fe6abc820	acr loa level	openid-connect	oidc-acr-mapper	\N	76459466-f04e-48c4-9264-e85d88f829f1
f6aea076-99de-4f5e-a9e1-d9264e323ffe	locale	openid-connect	oidc-usermodel-attribute-mapper	a6b150e6-04e7-4502-b55c-35a8d1b66eb0	\N
d3e07b52-8c72-46f7-9ae5-72c15c84675a	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	47820472-954a-4742-9cb3-cf82d38e5190	\N
f974d2f8-75e1-4273-9290-6d7a9ddf3ca1	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	47820472-954a-4742-9cb3-cf82d38e5190	\N
62979ea0-2694-4dcd-a137-91fdffb92e20	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	47820472-954a-4742-9cb3-cf82d38e5190	\N
cab9ea2c-a82f-4fdf-8e46-846d5d6b4ab6	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	9d270c10-830e-45fa-ac7d-f919ab5b73cd	\N
d1eda195-dd90-4c11-a897-fb978c0ad165	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	9d270c10-830e-45fa-ac7d-f919ab5b73cd	\N
b2055b1c-c6d7-46c9-a7cb-1273519d3e85	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	9d270c10-830e-45fa-ac7d-f919ab5b73cd	\N
3686e159-cee1-4ab4-ac65-3c2d0d122c3b	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	a54d40d9-eed6-4b4f-bc19-4b3c57f666b9	\N
36a9cc6a-9f5b-40b5-92ac-0daf780b1069	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	a54d40d9-eed6-4b4f-bc19-4b3c57f666b9	\N
d13ceae0-a62e-49a9-86f2-5f336b511c5d	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	a54d40d9-eed6-4b4f-bc19-4b3c57f666b9	\N
7a26d3ee-bbfb-4c1c-8d89-4bc0346612dd	group	openid-connect	oidc-group-membership-mapper	\N	7fa04efb-e52a-40d9-9c91-5caee279c390
2a1ee6ef-a610-4bdd-a189-cc9d81e11197	groups	openid-connect	oidc-group-membership-mapper	\N	1ab56eb4-8970-4b91-8807-45ee7e579c6f
9b1ec2d9-72c0-4d50-92a5-eb2df351b5cb	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	7515e33c-65b7-4518-ad98-3711bbbc8f9c	\N
a39fdeb1-4771-4c11-9529-9d56d445b9bd	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	7515e33c-65b7-4518-ad98-3711bbbc8f9c	\N
fe5a542f-ce50-49f8-b920-7730c51f13ba	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	7515e33c-65b7-4518-ad98-3711bbbc8f9c	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
fd6ff1a5-e0ad-4b79-911b-2348ef85afca	true	userinfo.token.claim
fd6ff1a5-e0ad-4b79-911b-2348ef85afca	locale	user.attribute
fd6ff1a5-e0ad-4b79-911b-2348ef85afca	true	id.token.claim
fd6ff1a5-e0ad-4b79-911b-2348ef85afca	true	access.token.claim
fd6ff1a5-e0ad-4b79-911b-2348ef85afca	locale	claim.name
fd6ff1a5-e0ad-4b79-911b-2348ef85afca	String	jsonType.label
29a5cec6-3474-4a68-9769-4b5f17dbb81a	false	single
29a5cec6-3474-4a68-9769-4b5f17dbb81a	Basic	attribute.nameformat
29a5cec6-3474-4a68-9769-4b5f17dbb81a	Role	attribute.name
018c6e2c-8153-43de-95dd-dcef6f4ad83c	true	userinfo.token.claim
018c6e2c-8153-43de-95dd-dcef6f4ad83c	locale	user.attribute
018c6e2c-8153-43de-95dd-dcef6f4ad83c	true	id.token.claim
018c6e2c-8153-43de-95dd-dcef6f4ad83c	true	access.token.claim
018c6e2c-8153-43de-95dd-dcef6f4ad83c	locale	claim.name
018c6e2c-8153-43de-95dd-dcef6f4ad83c	String	jsonType.label
0483d5af-fdb5-4222-bb23-702454a73a8b	true	userinfo.token.claim
0483d5af-fdb5-4222-bb23-702454a73a8b	website	user.attribute
0483d5af-fdb5-4222-bb23-702454a73a8b	true	id.token.claim
0483d5af-fdb5-4222-bb23-702454a73a8b	true	access.token.claim
0483d5af-fdb5-4222-bb23-702454a73a8b	website	claim.name
0483d5af-fdb5-4222-bb23-702454a73a8b	String	jsonType.label
0ff6adf9-1e73-4150-87fe-cc5af46a7103	true	userinfo.token.claim
0ff6adf9-1e73-4150-87fe-cc5af46a7103	zoneinfo	user.attribute
0ff6adf9-1e73-4150-87fe-cc5af46a7103	true	id.token.claim
0ff6adf9-1e73-4150-87fe-cc5af46a7103	true	access.token.claim
0ff6adf9-1e73-4150-87fe-cc5af46a7103	zoneinfo	claim.name
0ff6adf9-1e73-4150-87fe-cc5af46a7103	String	jsonType.label
27e9342b-0c8f-449c-9260-761faf932bf9	true	userinfo.token.claim
27e9342b-0c8f-449c-9260-761faf932bf9	true	id.token.claim
27e9342b-0c8f-449c-9260-761faf932bf9	true	access.token.claim
3be67ac3-5c24-49c9-a54b-a6801de5dc0c	true	userinfo.token.claim
3be67ac3-5c24-49c9-a54b-a6801de5dc0c	firstName	user.attribute
3be67ac3-5c24-49c9-a54b-a6801de5dc0c	true	id.token.claim
3be67ac3-5c24-49c9-a54b-a6801de5dc0c	true	access.token.claim
3be67ac3-5c24-49c9-a54b-a6801de5dc0c	given_name	claim.name
3be67ac3-5c24-49c9-a54b-a6801de5dc0c	String	jsonType.label
765df13b-4805-46f8-b069-b2bea0bf5d3c	true	userinfo.token.claim
765df13b-4805-46f8-b069-b2bea0bf5d3c	profile	user.attribute
765df13b-4805-46f8-b069-b2bea0bf5d3c	true	id.token.claim
765df13b-4805-46f8-b069-b2bea0bf5d3c	true	access.token.claim
765df13b-4805-46f8-b069-b2bea0bf5d3c	profile	claim.name
765df13b-4805-46f8-b069-b2bea0bf5d3c	String	jsonType.label
84ba7c54-9d45-46c9-aab5-cc2594357853	true	userinfo.token.claim
84ba7c54-9d45-46c9-aab5-cc2594357853	nickname	user.attribute
84ba7c54-9d45-46c9-aab5-cc2594357853	true	id.token.claim
84ba7c54-9d45-46c9-aab5-cc2594357853	true	access.token.claim
84ba7c54-9d45-46c9-aab5-cc2594357853	nickname	claim.name
84ba7c54-9d45-46c9-aab5-cc2594357853	String	jsonType.label
8d9ae76a-a48c-44a4-a69b-7cd8720406d9	true	userinfo.token.claim
8d9ae76a-a48c-44a4-a69b-7cd8720406d9	updatedAt	user.attribute
8d9ae76a-a48c-44a4-a69b-7cd8720406d9	true	id.token.claim
8d9ae76a-a48c-44a4-a69b-7cd8720406d9	true	access.token.claim
8d9ae76a-a48c-44a4-a69b-7cd8720406d9	updated_at	claim.name
8d9ae76a-a48c-44a4-a69b-7cd8720406d9	long	jsonType.label
9474f34e-784c-4bdf-a287-65d1303a6813	true	userinfo.token.claim
9474f34e-784c-4bdf-a287-65d1303a6813	birthdate	user.attribute
9474f34e-784c-4bdf-a287-65d1303a6813	true	id.token.claim
9474f34e-784c-4bdf-a287-65d1303a6813	true	access.token.claim
9474f34e-784c-4bdf-a287-65d1303a6813	birthdate	claim.name
9474f34e-784c-4bdf-a287-65d1303a6813	String	jsonType.label
94b8d993-7603-4178-8f0f-bc697f57b469	true	userinfo.token.claim
94b8d993-7603-4178-8f0f-bc697f57b469	middleName	user.attribute
94b8d993-7603-4178-8f0f-bc697f57b469	true	id.token.claim
94b8d993-7603-4178-8f0f-bc697f57b469	true	access.token.claim
94b8d993-7603-4178-8f0f-bc697f57b469	middle_name	claim.name
94b8d993-7603-4178-8f0f-bc697f57b469	String	jsonType.label
9675c8b9-d66a-43cf-aacb-82c197e4f318	true	userinfo.token.claim
9675c8b9-d66a-43cf-aacb-82c197e4f318	username	user.attribute
9675c8b9-d66a-43cf-aacb-82c197e4f318	true	id.token.claim
9675c8b9-d66a-43cf-aacb-82c197e4f318	true	access.token.claim
9675c8b9-d66a-43cf-aacb-82c197e4f318	preferred_username	claim.name
9675c8b9-d66a-43cf-aacb-82c197e4f318	String	jsonType.label
a96dbf8a-275b-4b50-87a1-e7743b1d2e29	true	userinfo.token.claim
a96dbf8a-275b-4b50-87a1-e7743b1d2e29	picture	user.attribute
a96dbf8a-275b-4b50-87a1-e7743b1d2e29	true	id.token.claim
a96dbf8a-275b-4b50-87a1-e7743b1d2e29	true	access.token.claim
a96dbf8a-275b-4b50-87a1-e7743b1d2e29	picture	claim.name
a96dbf8a-275b-4b50-87a1-e7743b1d2e29	String	jsonType.label
bf8b84fb-28b2-4687-8a03-5d6f96204b26	true	userinfo.token.claim
bf8b84fb-28b2-4687-8a03-5d6f96204b26	lastName	user.attribute
bf8b84fb-28b2-4687-8a03-5d6f96204b26	true	id.token.claim
bf8b84fb-28b2-4687-8a03-5d6f96204b26	true	access.token.claim
bf8b84fb-28b2-4687-8a03-5d6f96204b26	family_name	claim.name
bf8b84fb-28b2-4687-8a03-5d6f96204b26	String	jsonType.label
db3da741-28a5-4ba9-9833-6f66d59120f6	true	userinfo.token.claim
db3da741-28a5-4ba9-9833-6f66d59120f6	gender	user.attribute
db3da741-28a5-4ba9-9833-6f66d59120f6	true	id.token.claim
db3da741-28a5-4ba9-9833-6f66d59120f6	true	access.token.claim
db3da741-28a5-4ba9-9833-6f66d59120f6	gender	claim.name
db3da741-28a5-4ba9-9833-6f66d59120f6	String	jsonType.label
0810a475-5d71-442b-bedc-0e962451825b	true	userinfo.token.claim
0810a475-5d71-442b-bedc-0e962451825b	emailVerified	user.attribute
0810a475-5d71-442b-bedc-0e962451825b	true	id.token.claim
0810a475-5d71-442b-bedc-0e962451825b	true	access.token.claim
0810a475-5d71-442b-bedc-0e962451825b	email_verified	claim.name
0810a475-5d71-442b-bedc-0e962451825b	boolean	jsonType.label
1259d3c1-eed2-4ea6-a16e-a313b4e3cc01	true	userinfo.token.claim
1259d3c1-eed2-4ea6-a16e-a313b4e3cc01	email	user.attribute
1259d3c1-eed2-4ea6-a16e-a313b4e3cc01	true	id.token.claim
1259d3c1-eed2-4ea6-a16e-a313b4e3cc01	true	access.token.claim
1259d3c1-eed2-4ea6-a16e-a313b4e3cc01	email	claim.name
1259d3c1-eed2-4ea6-a16e-a313b4e3cc01	String	jsonType.label
65c62a75-506b-4af2-8e49-f8b59d19dee4	formatted	user.attribute.formatted
65c62a75-506b-4af2-8e49-f8b59d19dee4	country	user.attribute.country
65c62a75-506b-4af2-8e49-f8b59d19dee4	postal_code	user.attribute.postal_code
65c62a75-506b-4af2-8e49-f8b59d19dee4	true	userinfo.token.claim
65c62a75-506b-4af2-8e49-f8b59d19dee4	street	user.attribute.street
65c62a75-506b-4af2-8e49-f8b59d19dee4	true	id.token.claim
65c62a75-506b-4af2-8e49-f8b59d19dee4	region	user.attribute.region
65c62a75-506b-4af2-8e49-f8b59d19dee4	true	access.token.claim
65c62a75-506b-4af2-8e49-f8b59d19dee4	locality	user.attribute.locality
501e9839-1e76-4ecd-bdfe-cc2f2e0ea9d8	true	userinfo.token.claim
501e9839-1e76-4ecd-bdfe-cc2f2e0ea9d8	phoneNumberVerified	user.attribute
501e9839-1e76-4ecd-bdfe-cc2f2e0ea9d8	true	id.token.claim
501e9839-1e76-4ecd-bdfe-cc2f2e0ea9d8	true	access.token.claim
501e9839-1e76-4ecd-bdfe-cc2f2e0ea9d8	phone_number_verified	claim.name
501e9839-1e76-4ecd-bdfe-cc2f2e0ea9d8	boolean	jsonType.label
9b1ce6de-f13a-4f19-b3f0-3370aec09f3f	true	userinfo.token.claim
9b1ce6de-f13a-4f19-b3f0-3370aec09f3f	phoneNumber	user.attribute
9b1ce6de-f13a-4f19-b3f0-3370aec09f3f	true	id.token.claim
9b1ce6de-f13a-4f19-b3f0-3370aec09f3f	true	access.token.claim
9b1ce6de-f13a-4f19-b3f0-3370aec09f3f	phone_number	claim.name
9b1ce6de-f13a-4f19-b3f0-3370aec09f3f	String	jsonType.label
df490c0d-0e8c-4de8-b2e2-624d385074f7	true	multivalued
df490c0d-0e8c-4de8-b2e2-624d385074f7	foo	user.attribute
df490c0d-0e8c-4de8-b2e2-624d385074f7	true	access.token.claim
df490c0d-0e8c-4de8-b2e2-624d385074f7	realm_access.roles	claim.name
df490c0d-0e8c-4de8-b2e2-624d385074f7	String	jsonType.label
ff39e4f0-8261-44f6-ad97-2cb050789944	true	multivalued
ff39e4f0-8261-44f6-ad97-2cb050789944	foo	user.attribute
ff39e4f0-8261-44f6-ad97-2cb050789944	true	access.token.claim
ff39e4f0-8261-44f6-ad97-2cb050789944	resource_access.${client_id}.roles	claim.name
ff39e4f0-8261-44f6-ad97-2cb050789944	String	jsonType.label
2b6d114c-8924-4117-ac20-afca7416a9f9	true	userinfo.token.claim
2b6d114c-8924-4117-ac20-afca7416a9f9	username	user.attribute
2b6d114c-8924-4117-ac20-afca7416a9f9	true	id.token.claim
2b6d114c-8924-4117-ac20-afca7416a9f9	true	access.token.claim
2b6d114c-8924-4117-ac20-afca7416a9f9	upn	claim.name
2b6d114c-8924-4117-ac20-afca7416a9f9	String	jsonType.label
554f7b05-06e9-428a-a108-1cd0168c4c83	true	multivalued
554f7b05-06e9-428a-a108-1cd0168c4c83	foo	user.attribute
554f7b05-06e9-428a-a108-1cd0168c4c83	true	id.token.claim
554f7b05-06e9-428a-a108-1cd0168c4c83	true	access.token.claim
554f7b05-06e9-428a-a108-1cd0168c4c83	groups	claim.name
554f7b05-06e9-428a-a108-1cd0168c4c83	String	jsonType.label
11320ecc-5ac3-4c19-94ef-bade7e0c1f33	true	id.token.claim
11320ecc-5ac3-4c19-94ef-bade7e0c1f33	true	access.token.claim
5613a598-7d3d-4176-be5c-bb396694b5c6	false	single
5613a598-7d3d-4176-be5c-bb396694b5c6	Basic	attribute.nameformat
5613a598-7d3d-4176-be5c-bb396694b5c6	Role	attribute.name
0420a95e-604b-4ec6-b7ce-d5e399d6b93b	true	userinfo.token.claim
0420a95e-604b-4ec6-b7ce-d5e399d6b93b	firstName	user.attribute
0420a95e-604b-4ec6-b7ce-d5e399d6b93b	true	id.token.claim
0420a95e-604b-4ec6-b7ce-d5e399d6b93b	true	access.token.claim
0420a95e-604b-4ec6-b7ce-d5e399d6b93b	given_name	claim.name
0420a95e-604b-4ec6-b7ce-d5e399d6b93b	String	jsonType.label
19d34388-32c8-4300-836a-e1baf49d776a	true	userinfo.token.claim
19d34388-32c8-4300-836a-e1baf49d776a	website	user.attribute
19d34388-32c8-4300-836a-e1baf49d776a	true	id.token.claim
19d34388-32c8-4300-836a-e1baf49d776a	true	access.token.claim
19d34388-32c8-4300-836a-e1baf49d776a	website	claim.name
19d34388-32c8-4300-836a-e1baf49d776a	String	jsonType.label
21f35fec-91d8-4b83-8c49-c3b3f4d9899e	true	userinfo.token.claim
21f35fec-91d8-4b83-8c49-c3b3f4d9899e	nickname	user.attribute
21f35fec-91d8-4b83-8c49-c3b3f4d9899e	true	id.token.claim
21f35fec-91d8-4b83-8c49-c3b3f4d9899e	true	access.token.claim
21f35fec-91d8-4b83-8c49-c3b3f4d9899e	nickname	claim.name
21f35fec-91d8-4b83-8c49-c3b3f4d9899e	String	jsonType.label
2dc5d934-02e9-41d2-ba79-dd9f06958d48	true	userinfo.token.claim
2dc5d934-02e9-41d2-ba79-dd9f06958d48	locale	user.attribute
2dc5d934-02e9-41d2-ba79-dd9f06958d48	true	id.token.claim
2dc5d934-02e9-41d2-ba79-dd9f06958d48	true	access.token.claim
2dc5d934-02e9-41d2-ba79-dd9f06958d48	locale	claim.name
2dc5d934-02e9-41d2-ba79-dd9f06958d48	String	jsonType.label
35e63368-184e-4d6e-a7e4-1452521865d1	true	userinfo.token.claim
35e63368-184e-4d6e-a7e4-1452521865d1	username	user.attribute
35e63368-184e-4d6e-a7e4-1452521865d1	true	id.token.claim
35e63368-184e-4d6e-a7e4-1452521865d1	true	access.token.claim
35e63368-184e-4d6e-a7e4-1452521865d1	preferred_username	claim.name
35e63368-184e-4d6e-a7e4-1452521865d1	String	jsonType.label
371d1d57-c053-4373-9dfb-d910bb9d6ef9	true	userinfo.token.claim
371d1d57-c053-4373-9dfb-d910bb9d6ef9	gender	user.attribute
371d1d57-c053-4373-9dfb-d910bb9d6ef9	true	id.token.claim
371d1d57-c053-4373-9dfb-d910bb9d6ef9	true	access.token.claim
371d1d57-c053-4373-9dfb-d910bb9d6ef9	gender	claim.name
371d1d57-c053-4373-9dfb-d910bb9d6ef9	String	jsonType.label
39d4f92a-b645-4903-8fa2-6f86e352442c	true	userinfo.token.claim
39d4f92a-b645-4903-8fa2-6f86e352442c	zoneinfo	user.attribute
39d4f92a-b645-4903-8fa2-6f86e352442c	true	id.token.claim
39d4f92a-b645-4903-8fa2-6f86e352442c	true	access.token.claim
39d4f92a-b645-4903-8fa2-6f86e352442c	zoneinfo	claim.name
39d4f92a-b645-4903-8fa2-6f86e352442c	String	jsonType.label
62734e87-07c7-4a98-aba3-f02a405ca514	true	userinfo.token.claim
62734e87-07c7-4a98-aba3-f02a405ca514	true	id.token.claim
62734e87-07c7-4a98-aba3-f02a405ca514	true	access.token.claim
750f0f28-7c6e-4125-9d03-1d3c19ee47e3	true	userinfo.token.claim
750f0f28-7c6e-4125-9d03-1d3c19ee47e3	updatedAt	user.attribute
750f0f28-7c6e-4125-9d03-1d3c19ee47e3	true	id.token.claim
750f0f28-7c6e-4125-9d03-1d3c19ee47e3	true	access.token.claim
750f0f28-7c6e-4125-9d03-1d3c19ee47e3	updated_at	claim.name
750f0f28-7c6e-4125-9d03-1d3c19ee47e3	long	jsonType.label
8b937f0e-6959-4402-81c4-dcb6414a4904	true	userinfo.token.claim
8b937f0e-6959-4402-81c4-dcb6414a4904	lastName	user.attribute
8b937f0e-6959-4402-81c4-dcb6414a4904	true	id.token.claim
8b937f0e-6959-4402-81c4-dcb6414a4904	true	access.token.claim
8b937f0e-6959-4402-81c4-dcb6414a4904	family_name	claim.name
8b937f0e-6959-4402-81c4-dcb6414a4904	String	jsonType.label
8ca3714f-8e98-4b9f-8b67-0e2c9f0bd978	true	userinfo.token.claim
8ca3714f-8e98-4b9f-8b67-0e2c9f0bd978	birthdate	user.attribute
8ca3714f-8e98-4b9f-8b67-0e2c9f0bd978	true	id.token.claim
8ca3714f-8e98-4b9f-8b67-0e2c9f0bd978	true	access.token.claim
8ca3714f-8e98-4b9f-8b67-0e2c9f0bd978	birthdate	claim.name
8ca3714f-8e98-4b9f-8b67-0e2c9f0bd978	String	jsonType.label
8e5183d0-d4c5-4365-81b3-c35ed38bff25	true	userinfo.token.claim
8e5183d0-d4c5-4365-81b3-c35ed38bff25	middleName	user.attribute
8e5183d0-d4c5-4365-81b3-c35ed38bff25	true	id.token.claim
8e5183d0-d4c5-4365-81b3-c35ed38bff25	true	access.token.claim
8e5183d0-d4c5-4365-81b3-c35ed38bff25	middle_name	claim.name
8e5183d0-d4c5-4365-81b3-c35ed38bff25	String	jsonType.label
ab8bd18a-a33f-4090-9ccf-718cd9cfd06f	true	userinfo.token.claim
ab8bd18a-a33f-4090-9ccf-718cd9cfd06f	profile	user.attribute
ab8bd18a-a33f-4090-9ccf-718cd9cfd06f	true	id.token.claim
ab8bd18a-a33f-4090-9ccf-718cd9cfd06f	true	access.token.claim
ab8bd18a-a33f-4090-9ccf-718cd9cfd06f	profile	claim.name
ab8bd18a-a33f-4090-9ccf-718cd9cfd06f	String	jsonType.label
fcdd02eb-7e29-468d-aa53-8e6a76f8efa6	true	userinfo.token.claim
fcdd02eb-7e29-468d-aa53-8e6a76f8efa6	picture	user.attribute
fcdd02eb-7e29-468d-aa53-8e6a76f8efa6	true	id.token.claim
fcdd02eb-7e29-468d-aa53-8e6a76f8efa6	true	access.token.claim
fcdd02eb-7e29-468d-aa53-8e6a76f8efa6	picture	claim.name
fcdd02eb-7e29-468d-aa53-8e6a76f8efa6	String	jsonType.label
ca421f81-f3ff-47ff-8fe1-b8261ede459e	true	userinfo.token.claim
ca421f81-f3ff-47ff-8fe1-b8261ede459e	email	user.attribute
ca421f81-f3ff-47ff-8fe1-b8261ede459e	true	id.token.claim
ca421f81-f3ff-47ff-8fe1-b8261ede459e	true	access.token.claim
ca421f81-f3ff-47ff-8fe1-b8261ede459e	email	claim.name
ca421f81-f3ff-47ff-8fe1-b8261ede459e	String	jsonType.label
fdf9fc8c-3f92-4c78-bc08-090bf832ef9d	true	userinfo.token.claim
fdf9fc8c-3f92-4c78-bc08-090bf832ef9d	emailVerified	user.attribute
fdf9fc8c-3f92-4c78-bc08-090bf832ef9d	true	id.token.claim
fdf9fc8c-3f92-4c78-bc08-090bf832ef9d	true	access.token.claim
fdf9fc8c-3f92-4c78-bc08-090bf832ef9d	email_verified	claim.name
fdf9fc8c-3f92-4c78-bc08-090bf832ef9d	boolean	jsonType.label
4ed62f97-e548-4adc-8669-a344c97df41a	formatted	user.attribute.formatted
4ed62f97-e548-4adc-8669-a344c97df41a	country	user.attribute.country
4ed62f97-e548-4adc-8669-a344c97df41a	postal_code	user.attribute.postal_code
4ed62f97-e548-4adc-8669-a344c97df41a	true	userinfo.token.claim
4ed62f97-e548-4adc-8669-a344c97df41a	street	user.attribute.street
4ed62f97-e548-4adc-8669-a344c97df41a	true	id.token.claim
4ed62f97-e548-4adc-8669-a344c97df41a	region	user.attribute.region
4ed62f97-e548-4adc-8669-a344c97df41a	true	access.token.claim
4ed62f97-e548-4adc-8669-a344c97df41a	locality	user.attribute.locality
32c5acf3-f5b3-461d-930d-d55f838923c2	true	userinfo.token.claim
32c5acf3-f5b3-461d-930d-d55f838923c2	phoneNumberVerified	user.attribute
32c5acf3-f5b3-461d-930d-d55f838923c2	true	id.token.claim
32c5acf3-f5b3-461d-930d-d55f838923c2	true	access.token.claim
32c5acf3-f5b3-461d-930d-d55f838923c2	phone_number_verified	claim.name
32c5acf3-f5b3-461d-930d-d55f838923c2	boolean	jsonType.label
8e5289f1-d0d6-4337-ac51-f95ba93b157f	true	userinfo.token.claim
8e5289f1-d0d6-4337-ac51-f95ba93b157f	phoneNumber	user.attribute
8e5289f1-d0d6-4337-ac51-f95ba93b157f	true	id.token.claim
8e5289f1-d0d6-4337-ac51-f95ba93b157f	true	access.token.claim
8e5289f1-d0d6-4337-ac51-f95ba93b157f	phone_number	claim.name
8e5289f1-d0d6-4337-ac51-f95ba93b157f	String	jsonType.label
0723c60f-f526-45fd-984f-e537ba6344c1	true	multivalued
0723c60f-f526-45fd-984f-e537ba6344c1	foo	user.attribute
0723c60f-f526-45fd-984f-e537ba6344c1	true	access.token.claim
0723c60f-f526-45fd-984f-e537ba6344c1	realm_access.roles	claim.name
0723c60f-f526-45fd-984f-e537ba6344c1	String	jsonType.label
9f9963a8-ed1c-4268-891f-c1904ed33a05	true	multivalued
9f9963a8-ed1c-4268-891f-c1904ed33a05	foo	user.attribute
9f9963a8-ed1c-4268-891f-c1904ed33a05	true	access.token.claim
9f9963a8-ed1c-4268-891f-c1904ed33a05	resource_access.${client_id}.roles	claim.name
9f9963a8-ed1c-4268-891f-c1904ed33a05	String	jsonType.label
8e99c8e6-7b4f-4105-a2f5-2472cb9503ff	true	userinfo.token.claim
8e99c8e6-7b4f-4105-a2f5-2472cb9503ff	username	user.attribute
8e99c8e6-7b4f-4105-a2f5-2472cb9503ff	true	id.token.claim
8e99c8e6-7b4f-4105-a2f5-2472cb9503ff	true	access.token.claim
8e99c8e6-7b4f-4105-a2f5-2472cb9503ff	upn	claim.name
8e99c8e6-7b4f-4105-a2f5-2472cb9503ff	String	jsonType.label
ac599866-6e4f-42f2-a585-d66ca9aa473a	true	multivalued
ac599866-6e4f-42f2-a585-d66ca9aa473a	foo	user.attribute
ac599866-6e4f-42f2-a585-d66ca9aa473a	true	id.token.claim
ac599866-6e4f-42f2-a585-d66ca9aa473a	true	access.token.claim
ac599866-6e4f-42f2-a585-d66ca9aa473a	groups	claim.name
ac599866-6e4f-42f2-a585-d66ca9aa473a	String	jsonType.label
bd3cf0d1-6f42-4dd0-9a7c-286fe6abc820	true	id.token.claim
bd3cf0d1-6f42-4dd0-9a7c-286fe6abc820	true	access.token.claim
f6aea076-99de-4f5e-a9e1-d9264e323ffe	true	userinfo.token.claim
f6aea076-99de-4f5e-a9e1-d9264e323ffe	locale	user.attribute
f6aea076-99de-4f5e-a9e1-d9264e323ffe	true	id.token.claim
f6aea076-99de-4f5e-a9e1-d9264e323ffe	true	access.token.claim
f6aea076-99de-4f5e-a9e1-d9264e323ffe	locale	claim.name
f6aea076-99de-4f5e-a9e1-d9264e323ffe	String	jsonType.label
62979ea0-2694-4dcd-a137-91fdffb92e20	clientAddress	user.session.note
62979ea0-2694-4dcd-a137-91fdffb92e20	true	id.token.claim
62979ea0-2694-4dcd-a137-91fdffb92e20	true	access.token.claim
62979ea0-2694-4dcd-a137-91fdffb92e20	clientAddress	claim.name
62979ea0-2694-4dcd-a137-91fdffb92e20	String	jsonType.label
d3e07b52-8c72-46f7-9ae5-72c15c84675a	client_id	user.session.note
d3e07b52-8c72-46f7-9ae5-72c15c84675a	true	id.token.claim
d3e07b52-8c72-46f7-9ae5-72c15c84675a	true	access.token.claim
d3e07b52-8c72-46f7-9ae5-72c15c84675a	client_id	claim.name
d3e07b52-8c72-46f7-9ae5-72c15c84675a	String	jsonType.label
f974d2f8-75e1-4273-9290-6d7a9ddf3ca1	clientHost	user.session.note
f974d2f8-75e1-4273-9290-6d7a9ddf3ca1	true	id.token.claim
f974d2f8-75e1-4273-9290-6d7a9ddf3ca1	true	access.token.claim
f974d2f8-75e1-4273-9290-6d7a9ddf3ca1	clientHost	claim.name
f974d2f8-75e1-4273-9290-6d7a9ddf3ca1	String	jsonType.label
9f9963a8-ed1c-4268-891f-c1904ed33a05	true	userinfo.token.claim
9f9963a8-ed1c-4268-891f-c1904ed33a05	true	id.token.claim
0723c60f-f526-45fd-984f-e537ba6344c1	true	userinfo.token.claim
0723c60f-f526-45fd-984f-e537ba6344c1	true	id.token.claim
b2055b1c-c6d7-46c9-a7cb-1273519d3e85	clientAddress	user.session.note
b2055b1c-c6d7-46c9-a7cb-1273519d3e85	true	id.token.claim
b2055b1c-c6d7-46c9-a7cb-1273519d3e85	true	access.token.claim
b2055b1c-c6d7-46c9-a7cb-1273519d3e85	clientAddress	claim.name
b2055b1c-c6d7-46c9-a7cb-1273519d3e85	String	jsonType.label
cab9ea2c-a82f-4fdf-8e46-846d5d6b4ab6	client_id	user.session.note
cab9ea2c-a82f-4fdf-8e46-846d5d6b4ab6	true	id.token.claim
cab9ea2c-a82f-4fdf-8e46-846d5d6b4ab6	true	access.token.claim
cab9ea2c-a82f-4fdf-8e46-846d5d6b4ab6	client_id	claim.name
cab9ea2c-a82f-4fdf-8e46-846d5d6b4ab6	String	jsonType.label
d1eda195-dd90-4c11-a897-fb978c0ad165	clientHost	user.session.note
d1eda195-dd90-4c11-a897-fb978c0ad165	true	id.token.claim
d1eda195-dd90-4c11-a897-fb978c0ad165	true	access.token.claim
d1eda195-dd90-4c11-a897-fb978c0ad165	clientHost	claim.name
d1eda195-dd90-4c11-a897-fb978c0ad165	String	jsonType.label
3686e159-cee1-4ab4-ac65-3c2d0d122c3b	client_id	user.session.note
3686e159-cee1-4ab4-ac65-3c2d0d122c3b	true	id.token.claim
3686e159-cee1-4ab4-ac65-3c2d0d122c3b	true	access.token.claim
3686e159-cee1-4ab4-ac65-3c2d0d122c3b	client_id	claim.name
3686e159-cee1-4ab4-ac65-3c2d0d122c3b	String	jsonType.label
36a9cc6a-9f5b-40b5-92ac-0daf780b1069	clientHost	user.session.note
36a9cc6a-9f5b-40b5-92ac-0daf780b1069	true	id.token.claim
36a9cc6a-9f5b-40b5-92ac-0daf780b1069	true	access.token.claim
36a9cc6a-9f5b-40b5-92ac-0daf780b1069	clientHost	claim.name
36a9cc6a-9f5b-40b5-92ac-0daf780b1069	String	jsonType.label
d13ceae0-a62e-49a9-86f2-5f336b511c5d	clientAddress	user.session.note
d13ceae0-a62e-49a9-86f2-5f336b511c5d	true	id.token.claim
d13ceae0-a62e-49a9-86f2-5f336b511c5d	true	access.token.claim
d13ceae0-a62e-49a9-86f2-5f336b511c5d	clientAddress	claim.name
d13ceae0-a62e-49a9-86f2-5f336b511c5d	String	jsonType.label
7a26d3ee-bbfb-4c1c-8d89-4bc0346612dd	true	full.path
7a26d3ee-bbfb-4c1c-8d89-4bc0346612dd	true	id.token.claim
7a26d3ee-bbfb-4c1c-8d89-4bc0346612dd	true	access.token.claim
7a26d3ee-bbfb-4c1c-8d89-4bc0346612dd	group	claim.name
7a26d3ee-bbfb-4c1c-8d89-4bc0346612dd	true	userinfo.token.claim
2a1ee6ef-a610-4bdd-a189-cc9d81e11197	true	full.path
2a1ee6ef-a610-4bdd-a189-cc9d81e11197	true	id.token.claim
2a1ee6ef-a610-4bdd-a189-cc9d81e11197	true	access.token.claim
2a1ee6ef-a610-4bdd-a189-cc9d81e11197	true	userinfo.token.claim
2a1ee6ef-a610-4bdd-a189-cc9d81e11197	group	claim.name
2a1ee6ef-a610-4bdd-a189-cc9d81e11197	true	multivalued
9b1ec2d9-72c0-4d50-92a5-eb2df351b5cb	client_id	user.session.note
9b1ec2d9-72c0-4d50-92a5-eb2df351b5cb	true	id.token.claim
9b1ec2d9-72c0-4d50-92a5-eb2df351b5cb	true	access.token.claim
9b1ec2d9-72c0-4d50-92a5-eb2df351b5cb	client_id	claim.name
9b1ec2d9-72c0-4d50-92a5-eb2df351b5cb	String	jsonType.label
a39fdeb1-4771-4c11-9529-9d56d445b9bd	clientHost	user.session.note
a39fdeb1-4771-4c11-9529-9d56d445b9bd	true	id.token.claim
a39fdeb1-4771-4c11-9529-9d56d445b9bd	true	access.token.claim
a39fdeb1-4771-4c11-9529-9d56d445b9bd	clientHost	claim.name
a39fdeb1-4771-4c11-9529-9d56d445b9bd	String	jsonType.label
fe5a542f-ce50-49f8-b920-7730c51f13ba	clientAddress	user.session.note
fe5a542f-ce50-49f8-b920-7730c51f13ba	true	id.token.claim
fe5a542f-ce50-49f8-b920-7730c51f13ba	true	access.token.claim
fe5a542f-ce50-49f8-b920-7730c51f13ba	clientAddress	claim.name
fe5a542f-ce50-49f8-b920-7730c51f13ba	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
1cc45988-1774-48f1-af0c-82610082f679	60	300	60				t	f	0	keywind	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	461713e1-3a6d-44d1-af1f-051eae64b3a1	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	b55a7f53-fa7b-4cbb-b05f-a35611337974	d941d676-22db-4ff8-a265-518a4462c2b6	ffca43b4-d63d-4533-b30c-2a837f9c6b94	c2f76612-011e-497c-888c-d00c280ffba5	ee300e14-5742-43c5-ab90-83014c3510a6	2592000	f	900	t	f	139f0817-7246-42b7-97a6-2ca175fc3dc9	0	f	0	0	0f2dd4e0-1834-4473-8be0-55a056715089
fd31cefa-d2de-4b30-884e-96a0a709f62d	60	300	300				t	f	0	keywind	maps-eh	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	84f88319-ae5f-43af-8082-b672daef927d	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	8e11de5f-187c-4fc2-9133-07fd25ca1310	009bab91-b6ce-4533-a108-d3eb449174f7	5ca48a8b-b68f-497c-9064-315ab7154785	aa3a1651-4368-4df7-be32-49efee8e8ecf	f73f9483-ffd5-4ca2-b53e-d94b4b8bd5c5	2592000	f	900	t	f	89fee860-6f1c-4880-9108-7290940b40e1	0	t	0	0	2921b191-ba86-4827-8b6d-d0bbab82002f
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
realmReusableOtpCode	1cc45988-1774-48f1-af0c-82610082f679	false
realmReusableOtpCode	fd31cefa-d2de-4b30-884e-96a0a709f62d	false
oauth2DeviceCodeLifespan	fd31cefa-d2de-4b30-884e-96a0a709f62d	600
oauth2DevicePollingInterval	fd31cefa-d2de-4b30-884e-96a0a709f62d	5
cibaBackchannelTokenDeliveryMode	fd31cefa-d2de-4b30-884e-96a0a709f62d	poll
cibaExpiresIn	fd31cefa-d2de-4b30-884e-96a0a709f62d	120
cibaInterval	fd31cefa-d2de-4b30-884e-96a0a709f62d	5
cibaAuthRequestedUserHint	fd31cefa-d2de-4b30-884e-96a0a709f62d	login_hint
parRequestUriLifespan	fd31cefa-d2de-4b30-884e-96a0a709f62d	60
frontendUrl	fd31cefa-d2de-4b30-884e-96a0a709f62d	
userProfileEnabled	fd31cefa-d2de-4b30-884e-96a0a709f62d	true
acr.loa.map	fd31cefa-d2de-4b30-884e-96a0a709f62d	{}
clientSessionIdleTimeout	fd31cefa-d2de-4b30-884e-96a0a709f62d	0
clientSessionMaxLifespan	fd31cefa-d2de-4b30-884e-96a0a709f62d	0
clientOfflineSessionIdleTimeout	fd31cefa-d2de-4b30-884e-96a0a709f62d	0
clientOfflineSessionMaxLifespan	fd31cefa-d2de-4b30-884e-96a0a709f62d	0
displayName	fd31cefa-d2de-4b30-884e-96a0a709f62d	
displayNameHtml	fd31cefa-d2de-4b30-884e-96a0a709f62d	
bruteForceProtected	fd31cefa-d2de-4b30-884e-96a0a709f62d	false
permanentLockout	fd31cefa-d2de-4b30-884e-96a0a709f62d	false
maxFailureWaitSeconds	fd31cefa-d2de-4b30-884e-96a0a709f62d	900
minimumQuickLoginWaitSeconds	fd31cefa-d2de-4b30-884e-96a0a709f62d	60
waitIncrementSeconds	fd31cefa-d2de-4b30-884e-96a0a709f62d	60
quickLoginCheckMilliSeconds	fd31cefa-d2de-4b30-884e-96a0a709f62d	1000
maxDeltaTimeSeconds	fd31cefa-d2de-4b30-884e-96a0a709f62d	43200
failureFactor	fd31cefa-d2de-4b30-884e-96a0a709f62d	30
actionTokenGeneratedByAdminLifespan	fd31cefa-d2de-4b30-884e-96a0a709f62d	43200
actionTokenGeneratedByUserLifespan	fd31cefa-d2de-4b30-884e-96a0a709f62d	300
defaultSignatureAlgorithm	fd31cefa-d2de-4b30-884e-96a0a709f62d	RS256
offlineSessionMaxLifespanEnabled	fd31cefa-d2de-4b30-884e-96a0a709f62d	false
offlineSessionMaxLifespan	fd31cefa-d2de-4b30-884e-96a0a709f62d	5184000
webAuthnPolicyRpEntityName	fd31cefa-d2de-4b30-884e-96a0a709f62d	keycloak
webAuthnPolicySignatureAlgorithms	fd31cefa-d2de-4b30-884e-96a0a709f62d	ES256
webAuthnPolicyRpId	fd31cefa-d2de-4b30-884e-96a0a709f62d	
webAuthnPolicyAttestationConveyancePreference	fd31cefa-d2de-4b30-884e-96a0a709f62d	not specified
webAuthnPolicyAuthenticatorAttachment	fd31cefa-d2de-4b30-884e-96a0a709f62d	not specified
webAuthnPolicyRequireResidentKey	fd31cefa-d2de-4b30-884e-96a0a709f62d	not specified
webAuthnPolicyUserVerificationRequirement	fd31cefa-d2de-4b30-884e-96a0a709f62d	not specified
cibaBackchannelTokenDeliveryMode	1cc45988-1774-48f1-af0c-82610082f679	poll
cibaExpiresIn	1cc45988-1774-48f1-af0c-82610082f679	120
cibaAuthRequestedUserHint	1cc45988-1774-48f1-af0c-82610082f679	login_hint
parRequestUriLifespan	1cc45988-1774-48f1-af0c-82610082f679	60
cibaInterval	1cc45988-1774-48f1-af0c-82610082f679	5
displayName	1cc45988-1774-48f1-af0c-82610082f679	Keycloak
displayNameHtml	1cc45988-1774-48f1-af0c-82610082f679	<div class="kc-logo-text"><span>Keycloak</span></div>
bruteForceProtected	1cc45988-1774-48f1-af0c-82610082f679	false
permanentLockout	1cc45988-1774-48f1-af0c-82610082f679	false
maxFailureWaitSeconds	1cc45988-1774-48f1-af0c-82610082f679	900
minimumQuickLoginWaitSeconds	1cc45988-1774-48f1-af0c-82610082f679	60
waitIncrementSeconds	1cc45988-1774-48f1-af0c-82610082f679	60
quickLoginCheckMilliSeconds	1cc45988-1774-48f1-af0c-82610082f679	1000
maxDeltaTimeSeconds	1cc45988-1774-48f1-af0c-82610082f679	43200
failureFactor	1cc45988-1774-48f1-af0c-82610082f679	30
actionTokenGeneratedByAdminLifespan	1cc45988-1774-48f1-af0c-82610082f679	43200
actionTokenGeneratedByUserLifespan	1cc45988-1774-48f1-af0c-82610082f679	300
oauth2DeviceCodeLifespan	1cc45988-1774-48f1-af0c-82610082f679	600
oauth2DevicePollingInterval	1cc45988-1774-48f1-af0c-82610082f679	5
defaultSignatureAlgorithm	1cc45988-1774-48f1-af0c-82610082f679	RS256
offlineSessionMaxLifespanEnabled	1cc45988-1774-48f1-af0c-82610082f679	false
offlineSessionMaxLifespan	1cc45988-1774-48f1-af0c-82610082f679	5184000
clientSessionIdleTimeout	1cc45988-1774-48f1-af0c-82610082f679	0
clientSessionMaxLifespan	1cc45988-1774-48f1-af0c-82610082f679	0
clientOfflineSessionIdleTimeout	1cc45988-1774-48f1-af0c-82610082f679	0
clientOfflineSessionMaxLifespan	1cc45988-1774-48f1-af0c-82610082f679	0
webAuthnPolicyRpEntityName	1cc45988-1774-48f1-af0c-82610082f679	keycloak
webAuthnPolicySignatureAlgorithms	1cc45988-1774-48f1-af0c-82610082f679	ES256
webAuthnPolicyRpId	1cc45988-1774-48f1-af0c-82610082f679	
webAuthnPolicyAttestationConveyancePreference	1cc45988-1774-48f1-af0c-82610082f679	not specified
webAuthnPolicyAuthenticatorAttachment	1cc45988-1774-48f1-af0c-82610082f679	not specified
webAuthnPolicyRequireResidentKey	1cc45988-1774-48f1-af0c-82610082f679	not specified
webAuthnPolicyUserVerificationRequirement	1cc45988-1774-48f1-af0c-82610082f679	not specified
webAuthnPolicyCreateTimeout	1cc45988-1774-48f1-af0c-82610082f679	0
webAuthnPolicyAvoidSameAuthenticatorRegister	1cc45988-1774-48f1-af0c-82610082f679	false
webAuthnPolicyRpEntityNamePasswordless	1cc45988-1774-48f1-af0c-82610082f679	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	1cc45988-1774-48f1-af0c-82610082f679	ES256
webAuthnPolicyRpIdPasswordless	1cc45988-1774-48f1-af0c-82610082f679	
webAuthnPolicyAttestationConveyancePreferencePasswordless	1cc45988-1774-48f1-af0c-82610082f679	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	1cc45988-1774-48f1-af0c-82610082f679	not specified
webAuthnPolicyRequireResidentKeyPasswordless	1cc45988-1774-48f1-af0c-82610082f679	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	1cc45988-1774-48f1-af0c-82610082f679	not specified
webAuthnPolicyCreateTimeoutPasswordless	1cc45988-1774-48f1-af0c-82610082f679	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	1cc45988-1774-48f1-af0c-82610082f679	false
client-policies.profiles	1cc45988-1774-48f1-af0c-82610082f679	{"profiles":[]}
client-policies.policies	1cc45988-1774-48f1-af0c-82610082f679	{"policies":[]}
_browser_header.contentSecurityPolicyReportOnly	1cc45988-1774-48f1-af0c-82610082f679	
_browser_header.xContentTypeOptions	1cc45988-1774-48f1-af0c-82610082f679	nosniff
_browser_header.referrerPolicy	1cc45988-1774-48f1-af0c-82610082f679	no-referrer
_browser_header.xRobotsTag	1cc45988-1774-48f1-af0c-82610082f679	none
_browser_header.xFrameOptions	1cc45988-1774-48f1-af0c-82610082f679	SAMEORIGIN
_browser_header.xXSSProtection	1cc45988-1774-48f1-af0c-82610082f679	1; mode=block
_browser_header.contentSecurityPolicy	1cc45988-1774-48f1-af0c-82610082f679	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.strictTransportSecurity	1cc45988-1774-48f1-af0c-82610082f679	max-age=31536000; includeSubDomains
webAuthnPolicyCreateTimeout	fd31cefa-d2de-4b30-884e-96a0a709f62d	0
webAuthnPolicyAvoidSameAuthenticatorRegister	fd31cefa-d2de-4b30-884e-96a0a709f62d	false
webAuthnPolicyRpEntityNamePasswordless	fd31cefa-d2de-4b30-884e-96a0a709f62d	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	fd31cefa-d2de-4b30-884e-96a0a709f62d	ES256
webAuthnPolicyRpIdPasswordless	fd31cefa-d2de-4b30-884e-96a0a709f62d	
webAuthnPolicyAttestationConveyancePreferencePasswordless	fd31cefa-d2de-4b30-884e-96a0a709f62d	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	fd31cefa-d2de-4b30-884e-96a0a709f62d	not specified
webAuthnPolicyRequireResidentKeyPasswordless	fd31cefa-d2de-4b30-884e-96a0a709f62d	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	fd31cefa-d2de-4b30-884e-96a0a709f62d	not specified
webAuthnPolicyCreateTimeoutPasswordless	fd31cefa-d2de-4b30-884e-96a0a709f62d	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	fd31cefa-d2de-4b30-884e-96a0a709f62d	false
client-policies.profiles	fd31cefa-d2de-4b30-884e-96a0a709f62d	{"profiles":[]}
client-policies.policies	fd31cefa-d2de-4b30-884e-96a0a709f62d	{"policies":[]}
_browser_header.contentSecurityPolicyReportOnly	fd31cefa-d2de-4b30-884e-96a0a709f62d	
_browser_header.xContentTypeOptions	fd31cefa-d2de-4b30-884e-96a0a709f62d	nosniff
_browser_header.referrerPolicy	fd31cefa-d2de-4b30-884e-96a0a709f62d	no-referrer
_browser_header.xRobotsTag	fd31cefa-d2de-4b30-884e-96a0a709f62d	none
_browser_header.xFrameOptions	fd31cefa-d2de-4b30-884e-96a0a709f62d	SAMEORIGIN
_browser_header.contentSecurityPolicy	fd31cefa-d2de-4b30-884e-96a0a709f62d	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	fd31cefa-d2de-4b30-884e-96a0a709f62d	1; mode=block
_browser_header.strictTransportSecurity	fd31cefa-d2de-4b30-884e-96a0a709f62d	max-age=31536000; includeSubDomains
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
1cc45988-1774-48f1-af0c-82610082f679	jboss-logging
fd31cefa-d2de-4b30-884e-96a0a709f62d	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	1cc45988-1774-48f1-af0c-82610082f679
password	password	t	t	fd31cefa-d2de-4b30-884e-96a0a709f62d
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.redirect_uris (client_id, value) FROM stdin;
973ab1c7-211d-4310-8bc8-f2a30f74d7a6	/realms/master/account/*
d6e31b97-3056-4faf-9919-93710213550f	/realms/master/account/*
93129fbc-1e55-4d70-9c6c-a2e09e74066f	/admin/master/console/*
55f49bf2-eaeb-4533-975d-9a07d5d20835	/realms/maps-eh/account/*
a3282fc4-8a2a-45da-a49f-7bfa42d3a853	/realms/maps-eh/account/*
a6b150e6-04e7-4502-b55c-35a8d1b66eb0	/admin/maps-eh/console/*
9d270c10-830e-45fa-ac7d-f919ab5b73cd	http://localhost:8080/test/*
47820472-954a-4742-9cb3-cf82d38e5190	https://micare.whattadata.it/*
47820472-954a-4742-9cb3-cf82d38e5190	http://localhost:3000/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
95432916-72bd-457e-afaf-6b3cfcf31719	VERIFY_EMAIL	Verify Email	1cc45988-1774-48f1-af0c-82610082f679	t	f	VERIFY_EMAIL	50
43da7285-fde3-46e3-b040-b4148f2a388f	UPDATE_PROFILE	Update Profile	1cc45988-1774-48f1-af0c-82610082f679	t	f	UPDATE_PROFILE	40
b91a5fef-443e-4af1-b9ea-f33e36989c5b	CONFIGURE_TOTP	Configure OTP	1cc45988-1774-48f1-af0c-82610082f679	t	f	CONFIGURE_TOTP	10
542c28d4-2e61-46a9-ac5d-40e1cf12f04d	UPDATE_PASSWORD	Update Password	1cc45988-1774-48f1-af0c-82610082f679	t	f	UPDATE_PASSWORD	30
a8380d60-1fc1-4ca1-a3dd-929872d20197	TERMS_AND_CONDITIONS	Terms and Conditions	1cc45988-1774-48f1-af0c-82610082f679	f	f	TERMS_AND_CONDITIONS	20
07b9cada-666f-45ed-92fe-2670c738504b	delete_account	Delete Account	1cc45988-1774-48f1-af0c-82610082f679	f	f	delete_account	60
a7df8695-18aa-406b-93fc-7acc8a93d2e2	update_user_locale	Update User Locale	1cc45988-1774-48f1-af0c-82610082f679	t	f	update_user_locale	1000
3b8d599f-de51-42dd-9c70-b3fddd984cee	webauthn-register	Webauthn Register	1cc45988-1774-48f1-af0c-82610082f679	t	f	webauthn-register	70
7f84a362-5358-4522-841f-f05c8899e5a0	webauthn-register-passwordless	Webauthn Register Passwordless	1cc45988-1774-48f1-af0c-82610082f679	t	f	webauthn-register-passwordless	80
ae5b74f5-289b-4dc8-bfff-527aea59d551	VERIFY_EMAIL	Verify Email	fd31cefa-d2de-4b30-884e-96a0a709f62d	t	f	VERIFY_EMAIL	50
46f4efb6-bd2c-4001-8eb6-f9a559b456b4	UPDATE_PROFILE	Update Profile	fd31cefa-d2de-4b30-884e-96a0a709f62d	t	f	UPDATE_PROFILE	40
e21b5515-e5f0-4567-9f4f-40f6320bd180	CONFIGURE_TOTP	Configure OTP	fd31cefa-d2de-4b30-884e-96a0a709f62d	t	f	CONFIGURE_TOTP	10
ea5e98ce-0a75-4fc9-9cac-a52254f96b15	UPDATE_PASSWORD	Update Password	fd31cefa-d2de-4b30-884e-96a0a709f62d	t	f	UPDATE_PASSWORD	30
2b3fbf1a-8b14-4b5f-bfa5-d6b000546035	TERMS_AND_CONDITIONS	Terms and Conditions	fd31cefa-d2de-4b30-884e-96a0a709f62d	f	f	TERMS_AND_CONDITIONS	20
1d8b602e-6c2f-44e9-93f4-3fa1bc983352	delete_account	Delete Account	fd31cefa-d2de-4b30-884e-96a0a709f62d	f	f	delete_account	60
c477a096-a7d4-4fbd-8dc0-9ff9ad58081f	update_user_locale	Update User Locale	fd31cefa-d2de-4b30-884e-96a0a709f62d	t	f	update_user_locale	1000
6083bf46-535c-4157-ba36-b25ca1e0229f	webauthn-register	Webauthn Register	fd31cefa-d2de-4b30-884e-96a0a709f62d	t	f	webauthn-register	70
6d599ba3-415d-450d-a3ed-1045713259c0	webauthn-register-passwordless	Webauthn Register Passwordless	fd31cefa-d2de-4b30-884e-96a0a709f62d	t	f	webauthn-register-passwordless	80
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
1	080fbd1a-6b89-443e-9cb5-fd59e5f2a035
1	b4f3c86d-a7f0-4a7b-b200-fc3d4ff5d1dc
2	080fbd1a-6b89-443e-9cb5-fd59e5f2a035
2	b4f3c86d-a7f0-4a7b-b200-fc3d4ff5d1dc
4	080fbd1a-6b89-443e-9cb5-fd59e5f2a035
4	b4f3c86d-a7f0-4a7b-b200-fc3d4ff5d1dc
5	080fbd1a-6b89-443e-9cb5-fd59e5f2a035
5	b4f3c86d-a7f0-4a7b-b200-fc3d4ff5d1dc
6	080fbd1a-6b89-443e-9cb5-fd59e5f2a035
6	b4f3c86d-a7f0-4a7b-b200-fc3d4ff5d1dc
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
47820472-954a-4742-9cb3-cf82d38e5190	t	0	1
9d270c10-830e-45fa-ac7d-f919ab5b73cd	t	0	1
a54d40d9-eed6-4b4f-bc19-4b3c57f666b9	t	0	1
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
84e17510-6ac2-43d7-9665-fd37ca010d1f	Default Policy	A policy that grants access only for users within this realm	js	0	0	9d270c10-830e-45fa-ac7d-f919ab5b73cd	\N
87879993-638f-4d29-8c49-03db731c9c55	Default Permission	A permission that applies to the default resource type	resource	1	0	9d270c10-830e-45fa-ac7d-f919ab5b73cd	\N
f3dd65aa-ae61-4c95-bd19-771574c86113	Default Policy	A policy that grants access only for users within this realm	js	0	0	a54d40d9-eed6-4b4f-bc19-4b3c57f666b9	\N
260d3120-2d37-479f-aacf-c8e0d2b07831	Default Permission	A permission that applies to the default resource type	resource	1	0	a54d40d9-eed6-4b4f-bc19-4b3c57f666b9	\N
1e9829ba-d270-40ba-90f8-a84217f40c55	equip1_permission		scope	1	0	47820472-954a-4742-9cb3-cf82d38e5190	\N
2eb3054a-2aaa-4564-9534-de0406e0a980	equipe2_policy		group	1	0	47820472-954a-4742-9cb3-cf82d38e5190	\N
aeff6316-09a6-42fe-8c34-f59cc2ae1c3c	equipe1_policy		group	1	0	47820472-954a-4742-9cb3-cf82d38e5190	\N
4c6899c2-b082-4990-a1fd-378fe60807c6	equipe2_permission		scope	1	0	47820472-954a-4742-9cb3-cf82d38e5190	\N
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
33bc9c7c-07e2-4bf6-9a9e-6bc20ac1b77b	Default Resource	urn:mapseh-client:resources:default	\N	47820472-954a-4742-9cb3-cf82d38e5190	47820472-954a-4742-9cb3-cf82d38e5190	f	\N
862843be-eafa-4081-9a04-7e95cdcf7fa7	Default Resource	urn:test-client:resources:default	\N	9d270c10-830e-45fa-ac7d-f919ab5b73cd	9d270c10-830e-45fa-ac7d-f919ab5b73cd	f	\N
65d80440-3e16-4401-ae63-f273ce804910	Default Resource	urn:admin-cli:resources:default	\N	a54d40d9-eed6-4b4f-bc19-4b3c57f666b9	a54d40d9-eed6-4b4f-bc19-4b3c57f666b9	f	\N
1	1	tags	\N	47820472-954a-4742-9cb3-cf82d38e5190	47820472-954a-4742-9cb3-cf82d38e5190	f	\N
2	2	tags	\N	47820472-954a-4742-9cb3-cf82d38e5190	47820472-954a-4742-9cb3-cf82d38e5190	f	\N
4	4	tags	\N	47820472-954a-4742-9cb3-cf82d38e5190	47820472-954a-4742-9cb3-cf82d38e5190	f	\N
5	5	tags	\N	47820472-954a-4742-9cb3-cf82d38e5190	47820472-954a-4742-9cb3-cf82d38e5190	f	\N
6	6	tag	\N	47820472-954a-4742-9cb3-cf82d38e5190	47820472-954a-4742-9cb3-cf82d38e5190	f	\N
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
48c0b3af-1d29-4c71-9683-8009026ecb42	test		47820472-954a-4742-9cb3-cf82d38e5190	Test
df1a61c2-7700-460a-8c45-9462794009c3	equipe1		47820472-954a-4742-9cb3-cf82d38e5190	\N
560a30bb-c034-4977-9ea6-14f877449e57	equipe2		47820472-954a-4742-9cb3-cf82d38e5190	\N
080fbd1a-6b89-443e-9cb5-fd59e5f2a035	/therapist	\N	47820472-954a-4742-9cb3-cf82d38e5190	\N
b4f3c86d-a7f0-4a7b-b200-fc3d4ff5d1dc	/equipe2	\N	47820472-954a-4742-9cb3-cf82d38e5190	\N
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_uris (resource_id, value) FROM stdin;
33bc9c7c-07e2-4bf6-9a9e-6bc20ac1b77b	/*
862843be-eafa-4081-9a04-7e95cdcf7fa7	/*
65d80440-3e16-4401-ae63-f273ce804910	/*
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
d6e31b97-3056-4faf-9919-93710213550f	c7701e90-2f37-45ff-83b0-16aeb994aad5
d6e31b97-3056-4faf-9919-93710213550f	841118fa-b9a0-409b-82a2-b26b89e6de26
a3282fc4-8a2a-45da-a49f-7bfa42d3a853	546e7fda-5f50-467b-93f4-3590d6ecf010
a3282fc4-8a2a-45da-a49f-7bfa42d3a853	b7f0d6f6-bd2e-4786-ac43-3d4444d44f49
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
df1a61c2-7700-460a-8c45-9462794009c3	1e9829ba-d270-40ba-90f8-a84217f40c55
560a30bb-c034-4977-9ea6-14f877449e57	4c6899c2-b082-4990-a1fd-378fe60807c6
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
phoneNumber	34512312312	b6e9bfaf-9a36-483a-9c6d-cb1e39d2736b	2a3585f2-b687-4ad3-bd14-b0adbb1ba249
formatted	Via Ignota 4, MI 20100	b6e9bfaf-9a36-483a-9c6d-cb1e39d2736b	60f9f5b8-0965-4968-b1dd-3c0d29cb271f
phoneNumber	3401212123	88994533-2f45-4ceb-8782-dcb8365e9f44	1fdd61d2-f61e-4cb9-a7fb-457863e0a731
formatted	viale Ignota, 4	88994533-2f45-4ceb-8782-dcb8365e9f44	aee15a5d-7400-4118-bdfc-645964c7eb33
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
e7f62dc9-eb51-4c47-941c-a7d40d42c27d	\N	4452f223-c198-46c0-a3a6-20e860824c4d	f	t	\N	\N	\N	1cc45988-1774-48f1-af0c-82610082f679	kcadmin	1689258888853	\N	0
7471bc53-fa03-48ca-9fa3-6abba7fe4a29	\N	9bd7268a-a3f5-4748-9a52-7bce7c7bbc6c	f	t	\N	\N	\N	fd31cefa-d2de-4b30-884e-96a0a709f62d	service-account-mapseh-client	1689259064373	47820472-954a-4742-9cb3-cf82d38e5190	0
b6e9bfaf-9a36-483a-9c6d-cb1e39d2736b	a@b.it	a@b.it	t	t	\N	Test	Terapeuta	fd31cefa-d2de-4b30-884e-96a0a709f62d	testterapist	1689259111712	\N	0
bc61c7f2-518f-4f33-8ec9-cbf74d3c30c5	mro@asd.it	mro@asd.it	t	t	\N	Mario	Rossi	fd31cefa-d2de-4b30-884e-96a0a709f62d	mrossi	1689259141299	\N	0
88994533-2f45-4ceb-8782-dcb8365e9f44	elia.guarnieri@test.it	elia.guarnieri@test.it	t	t	\N	Elia	Guarnieri	fd31cefa-d2de-4b30-884e-96a0a709f62d	eguarnieri	1693837260275	\N	0
a2bfd4e4-2668-49e3-a504-c1a707f23903	\N	2faa2442-b267-4aea-88e7-78f1ad7d6e26	f	t	\N	\N	\N	fd31cefa-d2de-4b30-884e-96a0a709f62d	service-account-test-client	1694017589199	9d270c10-830e-45fa-ac7d-f919ab5b73cd	0
d4590f84-fa47-442b-a0f4-a33acb27a8c9	\N	3340a73d-23ba-42e5-9ba5-c8bd042e7ad8	f	t	\N	\N	\N	1cc45988-1774-48f1-af0c-82610082f679	service-account-admin-cli	1694018538616	a54d40d9-eed6-4b4f-bc19-4b3c57f666b9	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
040226dd-69ce-4c4c-9908-baa131b50fcb	bc61c7f2-518f-4f33-8ec9-cbf74d3c30c5
13c5a252-369b-4213-8a83-dd381d658b73	b6e9bfaf-9a36-483a-9c6d-cb1e39d2736b
13c5a252-369b-4213-8a83-dd381d658b73	88994533-2f45-4ceb-8782-dcb8365e9f44
ec05b00b-3d76-4879-9cbb-add9c8f82ae2	88994533-2f45-4ceb-8782-dcb8365e9f44
b385c45f-9aa3-4635-9950-87e1de5fd8f2	b6e9bfaf-9a36-483a-9c6d-cb1e39d2736b
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
0f2dd4e0-1834-4473-8be0-55a056715089	e7f62dc9-eb51-4c47-941c-a7d40d42c27d
5d073cb7-a36d-4e14-9d15-bd104bcca43f	e7f62dc9-eb51-4c47-941c-a7d40d42c27d
9feb4fab-c2dc-42dd-8c30-774f80df88c0	e7f62dc9-eb51-4c47-941c-a7d40d42c27d
a0b2d961-71a0-4990-a8c2-cfb5572de8cb	e7f62dc9-eb51-4c47-941c-a7d40d42c27d
70668dbd-da95-462b-81b2-8ce92b5e1700	e7f62dc9-eb51-4c47-941c-a7d40d42c27d
5e29451e-b187-4a19-99a3-56c6bc216466	e7f62dc9-eb51-4c47-941c-a7d40d42c27d
1d478edd-4633-4cf4-8594-532a18c6ee84	e7f62dc9-eb51-4c47-941c-a7d40d42c27d
f3baa98d-d745-424f-872a-14e9344217ad	e7f62dc9-eb51-4c47-941c-a7d40d42c27d
d45b1c34-d013-429b-a02e-158d9bed0ce4	e7f62dc9-eb51-4c47-941c-a7d40d42c27d
5adc8e13-2cbb-469e-a2f9-4c40b5b31706	e7f62dc9-eb51-4c47-941c-a7d40d42c27d
625c609c-ad09-4d98-afaa-3cd3e910c8f5	e7f62dc9-eb51-4c47-941c-a7d40d42c27d
3222d370-538d-4350-96af-0be129bf1edb	e7f62dc9-eb51-4c47-941c-a7d40d42c27d
d611a39c-01ed-4cfb-80bb-1b4b909febde	e7f62dc9-eb51-4c47-941c-a7d40d42c27d
4ec65493-cf9a-46fc-85d3-4baff967957c	e7f62dc9-eb51-4c47-941c-a7d40d42c27d
d6d39c3b-d102-4523-b02e-f81d3df8bc86	e7f62dc9-eb51-4c47-941c-a7d40d42c27d
2e5ce3b1-240d-40f6-a6aa-7e28b187a3b7	e7f62dc9-eb51-4c47-941c-a7d40d42c27d
742cbe81-7b3b-475d-b40b-aefc575046a4	e7f62dc9-eb51-4c47-941c-a7d40d42c27d
fa92ccde-91e9-4ddb-bcd3-c682addaf536	e7f62dc9-eb51-4c47-941c-a7d40d42c27d
9c3035f3-99b8-4e91-b57b-ca246adaf9a8	e7f62dc9-eb51-4c47-941c-a7d40d42c27d
2921b191-ba86-4827-8b6d-d0bbab82002f	7471bc53-fa03-48ca-9fa3-6abba7fe4a29
77453a93-79c0-422b-9e82-77a382ebb647	7471bc53-fa03-48ca-9fa3-6abba7fe4a29
2921b191-ba86-4827-8b6d-d0bbab82002f	b6e9bfaf-9a36-483a-9c6d-cb1e39d2736b
2a2068a7-6ed5-4b6c-af6f-bf3fe058de3c	b6e9bfaf-9a36-483a-9c6d-cb1e39d2736b
2921b191-ba86-4827-8b6d-d0bbab82002f	bc61c7f2-518f-4f33-8ec9-cbf74d3c30c5
3359778c-b9ee-4c8c-8232-31906cfd30d7	bc61c7f2-518f-4f33-8ec9-cbf74d3c30c5
2921b191-ba86-4827-8b6d-d0bbab82002f	88994533-2f45-4ceb-8782-dcb8365e9f44
75abe5a8-ebf2-4eec-bcf3-1a41ed0933e6	b6e9bfaf-9a36-483a-9c6d-cb1e39d2736b
2921b191-ba86-4827-8b6d-d0bbab82002f	a2bfd4e4-2668-49e3-a504-c1a707f23903
c2dfadd0-4aca-4437-95b9-3815f11c11b5	a2bfd4e4-2668-49e3-a504-c1a707f23903
0f2dd4e0-1834-4473-8be0-55a056715089	d4590f84-fa47-442b-a0f4-a33acb27a8c9
4767ae6d-55df-4dd1-9148-682006e2af6c	d4590f84-fa47-442b-a0f4-a33acb27a8c9
75abe5a8-ebf2-4eec-bcf3-1a41ed0933e6	7471bc53-fa03-48ca-9fa3-6abba7fe4a29
febeb978-3d48-4794-8883-1163acb36c7c	7471bc53-fa03-48ca-9fa3-6abba7fe4a29
cd2e4928-8687-40fe-8a82-793b1f7883a8	7471bc53-fa03-48ca-9fa3-6abba7fe4a29
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.web_origins (client_id, value) FROM stdin;
93129fbc-1e55-4d70-9c6c-a2e09e74066f	+
a6b150e6-04e7-4502-b55c-35a8d1b66eb0	+
9d270c10-830e-45fa-ac7d-f919ab5b73cd	http://localhost:8080
47820472-954a-4742-9cb3-cf82d38e5190	https://micare.whattadata.it
47820472-954a-4742-9cb3-cf82d38e5190	http://localhost:3000
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

