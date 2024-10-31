--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2 (Debian 13.2-1.pgdg100+1)
-- Dumped by pg_dump version 13.2 (Debian 13.2-1.pgdg100+1)

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
    value character varying(4000),
    name character varying(255) NOT NULL
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
    policy_enforce_mode character varying(15) NOT NULL,
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
    decision_strategy character varying(20),
    logic character varying(20),
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
9279b41e-3a65-4b57-8865-ba6a228606a5	d80b8ccd-fe20-4644-93f9-98cd3f0b2738
56b2b109-8818-433a-9dcf-582ccb8901dd	4345616b-ab5d-408e-b680-14424ee0adf4
0414b119-19bf-4a84-9b05-9687e819a9df	469e0ae1-f365-4251-a453-922df7497d7f
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
59e5b274-5689-4a06-a48e-207cb27454ae	\N	auth-cookie	master	2759373b-ad08-4fae-bbf2-407d3be938ef	2	10	f	\N	\N
198db121-37b5-4160-a804-899315048c5c	\N	auth-spnego	master	2759373b-ad08-4fae-bbf2-407d3be938ef	3	20	f	\N	\N
f7c2d82a-2f52-41af-8358-150eb3798b85	\N	identity-provider-redirector	master	2759373b-ad08-4fae-bbf2-407d3be938ef	2	25	f	\N	\N
544fedf8-e0fb-4dc6-9b1e-25e33bd63bdf	\N	\N	master	2759373b-ad08-4fae-bbf2-407d3be938ef	2	30	t	eb10930a-e894-4e0a-836b-966618d86961	\N
456e4bd6-acaa-45f6-9a1c-f754ec63f673	\N	auth-username-password-form	master	eb10930a-e894-4e0a-836b-966618d86961	0	10	f	\N	\N
3fdd3fb7-bb00-492b-8a56-754fcc63c83a	\N	\N	master	eb10930a-e894-4e0a-836b-966618d86961	1	20	t	b4b11980-7a11-4b98-b97f-96bc1736bc0a	\N
6bee8f3a-3cc0-4cd2-b22c-496387fbf36f	\N	conditional-user-configured	master	b4b11980-7a11-4b98-b97f-96bc1736bc0a	0	10	f	\N	\N
34169e03-1555-46fa-903e-8dbdff66e101	\N	auth-otp-form	master	b4b11980-7a11-4b98-b97f-96bc1736bc0a	0	20	f	\N	\N
83566c5d-fc0b-42e0-994c-3c54068bed3c	\N	direct-grant-validate-username	master	12c2ea48-a47a-4aec-93ee-e0e76ebb1036	0	10	f	\N	\N
7505b18b-4b4e-4cf5-a218-3b0ddc4ee407	\N	direct-grant-validate-password	master	12c2ea48-a47a-4aec-93ee-e0e76ebb1036	0	20	f	\N	\N
e91592ce-6032-4814-806a-9fb6173d19a0	\N	\N	master	12c2ea48-a47a-4aec-93ee-e0e76ebb1036	1	30	t	f15b7a6f-6f64-4317-b1a3-9610fb2ede5b	\N
c33904f2-fc16-40ba-9937-6099a915c0c8	\N	conditional-user-configured	master	f15b7a6f-6f64-4317-b1a3-9610fb2ede5b	0	10	f	\N	\N
a0335071-9702-40b6-8768-fbdc929f603e	\N	direct-grant-validate-otp	master	f15b7a6f-6f64-4317-b1a3-9610fb2ede5b	0	20	f	\N	\N
05b775d2-cfeb-4588-8909-114ef8437fe4	\N	registration-page-form	master	8c7ae44f-e177-4ff4-8638-0bde1a03f034	0	10	t	9633bd51-4d1c-4177-af4f-bef4b034a740	\N
98be7054-dd32-406d-9b1d-028e233ea462	\N	registration-user-creation	master	9633bd51-4d1c-4177-af4f-bef4b034a740	0	20	f	\N	\N
be6dc928-c649-4e1a-abb6-41606f5c269d	\N	registration-profile-action	master	9633bd51-4d1c-4177-af4f-bef4b034a740	0	40	f	\N	\N
f62f3968-b81a-49f4-aada-2ac264e9b271	\N	registration-password-action	master	9633bd51-4d1c-4177-af4f-bef4b034a740	0	50	f	\N	\N
8f093a3e-474d-4677-84b3-5da205c9d622	\N	registration-recaptcha-action	master	9633bd51-4d1c-4177-af4f-bef4b034a740	3	60	f	\N	\N
fb15126f-42a8-4dbd-8340-25ccde4e7bf9	\N	reset-credentials-choose-user	master	710ce88b-7e48-4443-bc75-6261c48c129f	0	10	f	\N	\N
53a82e97-1c37-4905-9bb6-94f63e74092f	\N	reset-credential-email	master	710ce88b-7e48-4443-bc75-6261c48c129f	0	20	f	\N	\N
b238860c-9c22-447c-83de-02a45176a9db	\N	reset-password	master	710ce88b-7e48-4443-bc75-6261c48c129f	0	30	f	\N	\N
81f65dd4-5cef-4eec-af32-409d53ed4300	\N	\N	master	710ce88b-7e48-4443-bc75-6261c48c129f	1	40	t	5fb3df41-312c-4d2d-bf2b-777e32432460	\N
67528eba-e688-4866-9262-bcd284a42bd1	\N	conditional-user-configured	master	5fb3df41-312c-4d2d-bf2b-777e32432460	0	10	f	\N	\N
97b28de8-4bd2-4ee0-aba2-324297852e9b	\N	reset-otp	master	5fb3df41-312c-4d2d-bf2b-777e32432460	0	20	f	\N	\N
afd1c7c1-61db-49b4-ae69-86fd14e2dff6	\N	client-secret	master	dd1eb685-1e56-488a-a912-3134aa270089	2	10	f	\N	\N
07e98154-2e98-43a1-83c3-69898c7f7b62	\N	client-jwt	master	dd1eb685-1e56-488a-a912-3134aa270089	2	20	f	\N	\N
6af45f85-baa0-424c-8248-757c21dd7748	\N	client-secret-jwt	master	dd1eb685-1e56-488a-a912-3134aa270089	2	30	f	\N	\N
7b1bc7c8-0c8e-49f3-9b83-6d94f2049790	\N	client-x509	master	dd1eb685-1e56-488a-a912-3134aa270089	2	40	f	\N	\N
59ac6b6d-07fe-480e-987f-9ba61a158496	\N	idp-review-profile	master	9e49be7e-6917-4df4-9b05-2e5c733ba904	0	10	f	\N	8c8fd65f-9af9-41a7-8258-1334de3294b9
a786344a-5f4f-4d67-9334-be36116e5aea	\N	\N	master	9e49be7e-6917-4df4-9b05-2e5c733ba904	0	20	t	bb38b33c-cc91-405f-ba64-cdd5b62f45a8	\N
cb916416-f885-44ea-97f9-114683fde5e5	\N	idp-create-user-if-unique	master	bb38b33c-cc91-405f-ba64-cdd5b62f45a8	2	10	f	\N	26d250e0-a8a1-46d0-b246-46a07dc4e93a
5752a4dc-c64b-47d5-80ee-ce3e42aee185	\N	\N	master	bb38b33c-cc91-405f-ba64-cdd5b62f45a8	2	20	t	3e558b6e-d972-44fd-a951-d898c57f7518	\N
c7e8031f-3c7b-4556-9680-eb3b8d74d02b	\N	idp-confirm-link	master	3e558b6e-d972-44fd-a951-d898c57f7518	0	10	f	\N	\N
751f0253-2fb8-4f1c-8506-73a0502fb8e8	\N	\N	master	3e558b6e-d972-44fd-a951-d898c57f7518	0	20	t	aac02fe2-7fa2-440f-8100-e34782168cf0	\N
469534f3-6fed-4712-abd4-0ed821684d6a	\N	idp-email-verification	master	aac02fe2-7fa2-440f-8100-e34782168cf0	2	10	f	\N	\N
154c0984-822a-4920-8644-83a5aa0321ca	\N	\N	master	aac02fe2-7fa2-440f-8100-e34782168cf0	2	20	t	791d8293-2a61-43e6-a34a-9f89e0e6d240	\N
e9c2161b-3880-417b-8824-617f586a77d6	\N	idp-username-password-form	master	791d8293-2a61-43e6-a34a-9f89e0e6d240	0	10	f	\N	\N
430ea0e1-7a37-4963-829c-96b95966ea69	\N	\N	master	791d8293-2a61-43e6-a34a-9f89e0e6d240	1	20	t	a76684d3-4c36-42b7-a7c0-e425e6826c85	\N
c4bae248-c5f8-4024-bb52-366e82105789	\N	conditional-user-configured	master	a76684d3-4c36-42b7-a7c0-e425e6826c85	0	10	f	\N	\N
c71fb33e-6338-42a4-b093-2d340531f821	\N	auth-otp-form	master	a76684d3-4c36-42b7-a7c0-e425e6826c85	0	20	f	\N	\N
e5b776d7-565e-4c84-a9d2-cc3c4dee9ad6	\N	http-basic-authenticator	master	10e6144c-0407-452f-8e0d-774a45e8ed4e	0	10	f	\N	\N
71da3cbb-35e6-473f-b036-b2a97c0454f8	\N	docker-http-basic-authenticator	master	0dca4dca-413a-4083-83da-b8c3474d18d8	0	10	f	\N	\N
8dfc02c9-f927-4868-8e07-8f488b3e014f	\N	no-cookie-redirect	master	99471bf6-8d82-4ae2-af91-696d78b3953c	0	10	f	\N	\N
f3733fb9-84c6-4322-91e2-a36ea2a1c3e1	\N	\N	master	99471bf6-8d82-4ae2-af91-696d78b3953c	0	20	t	fa53b7ba-88d3-4d51-aa3a-dc52688ca5ca	\N
2273e6c9-4a89-4baf-becc-cb9d46e2b4d6	\N	basic-auth	master	fa53b7ba-88d3-4d51-aa3a-dc52688ca5ca	0	10	f	\N	\N
8b789d7f-8c41-4b0d-8171-0114983cd1dd	\N	basic-auth-otp	master	fa53b7ba-88d3-4d51-aa3a-dc52688ca5ca	3	20	f	\N	\N
032314ca-f177-41ce-b99e-dd23038c20dd	\N	auth-spnego	master	fa53b7ba-88d3-4d51-aa3a-dc52688ca5ca	3	30	f	\N	\N
18493a5b-1f3d-452f-a8bf-5f7cf9e8dda1	\N	auth-cookie	tyk	68e617f0-a3fa-4e54-b654-b5a7468de2dc	2	10	f	\N	\N
677b3003-e824-4266-9b5e-40abe8456ab0	\N	auth-spnego	tyk	68e617f0-a3fa-4e54-b654-b5a7468de2dc	3	20	f	\N	\N
53a35ac1-1ed3-41e7-bf5f-511b2b13ebc7	\N	identity-provider-redirector	tyk	68e617f0-a3fa-4e54-b654-b5a7468de2dc	2	25	f	\N	\N
c506a33d-1e36-4104-b18c-957c0c9608e9	\N	\N	tyk	68e617f0-a3fa-4e54-b654-b5a7468de2dc	2	30	t	9cf6632f-d4fe-4799-8b26-d5b52dbf24af	\N
07668ac5-7254-48ba-ba37-ef94c153a2e3	\N	auth-username-password-form	tyk	9cf6632f-d4fe-4799-8b26-d5b52dbf24af	0	10	f	\N	\N
fd4c1cff-3d0f-4dec-8a29-cb602bd137d2	\N	\N	tyk	9cf6632f-d4fe-4799-8b26-d5b52dbf24af	1	20	t	4f226875-4e0a-4d8c-892c-04c66c8607f9	\N
35601a9a-8520-4178-a48e-847c1d9cd86d	\N	conditional-user-configured	tyk	4f226875-4e0a-4d8c-892c-04c66c8607f9	0	10	f	\N	\N
00b34f09-14f2-423d-83b9-ee4a4f81f61f	\N	auth-otp-form	tyk	4f226875-4e0a-4d8c-892c-04c66c8607f9	0	20	f	\N	\N
4b871b6c-614c-4a6b-b9a8-9e37adbacf23	\N	direct-grant-validate-username	tyk	2164e41c-8c19-41c4-b7bd-2415c1e4c6e4	0	10	f	\N	\N
364d35c7-7fee-439e-89fd-b7b5b7c47039	\N	direct-grant-validate-password	tyk	2164e41c-8c19-41c4-b7bd-2415c1e4c6e4	0	20	f	\N	\N
e705e014-5806-435b-9246-e241de0fd72f	\N	\N	tyk	2164e41c-8c19-41c4-b7bd-2415c1e4c6e4	1	30	t	19e55f23-74c5-4190-8f5a-e588f559301b	\N
4af15905-19c6-4d64-88bd-1da5cc81f101	\N	conditional-user-configured	tyk	19e55f23-74c5-4190-8f5a-e588f559301b	0	10	f	\N	\N
20d7973b-68d9-4b32-b6fb-a1313e79c7f4	\N	direct-grant-validate-otp	tyk	19e55f23-74c5-4190-8f5a-e588f559301b	0	20	f	\N	\N
d3baa4f4-a12e-4432-b025-8267cd4b8cb4	\N	registration-page-form	tyk	1089f8d7-909b-4ca2-aef9-98c5905607be	0	10	t	a445fa7b-e338-4790-ac61-7fe89619048c	\N
f2716064-d4e0-4aec-9a01-97ffdc28de8f	\N	registration-user-creation	tyk	a445fa7b-e338-4790-ac61-7fe89619048c	0	20	f	\N	\N
de53e9e2-bfe3-4cc1-a5a3-df7f98d61814	\N	registration-profile-action	tyk	a445fa7b-e338-4790-ac61-7fe89619048c	0	40	f	\N	\N
f9c938fe-17a3-4403-bbd6-6fbc0f918b3d	\N	registration-password-action	tyk	a445fa7b-e338-4790-ac61-7fe89619048c	0	50	f	\N	\N
7723325e-378c-4659-a9b4-d799819c9677	\N	registration-recaptcha-action	tyk	a445fa7b-e338-4790-ac61-7fe89619048c	3	60	f	\N	\N
24748308-f054-470e-96ed-6b056f06b236	\N	reset-credentials-choose-user	tyk	e80e515d-05c2-4f19-a225-d266513980cf	0	10	f	\N	\N
b95562a0-0fd8-4be9-8f72-633f4939f145	\N	reset-credential-email	tyk	e80e515d-05c2-4f19-a225-d266513980cf	0	20	f	\N	\N
bcb576f8-14e3-4372-a14f-f693fd89fda7	\N	reset-password	tyk	e80e515d-05c2-4f19-a225-d266513980cf	0	30	f	\N	\N
8d6a4146-f16e-47ef-8b66-af0bde82cd92	\N	\N	tyk	e80e515d-05c2-4f19-a225-d266513980cf	1	40	t	16cad86f-a560-4ce3-9773-09dc03da51e1	\N
f0f84d53-6ee3-4be7-958e-753b9dd545b7	\N	conditional-user-configured	tyk	16cad86f-a560-4ce3-9773-09dc03da51e1	0	10	f	\N	\N
5a4613a9-f603-4ca2-af39-28482be6edee	\N	reset-otp	tyk	16cad86f-a560-4ce3-9773-09dc03da51e1	0	20	f	\N	\N
655dc308-13b4-42cf-868b-a332edb9be2e	\N	client-secret	tyk	b58656b0-b4f5-4d11-b0c4-c29ac4d65c61	2	10	f	\N	\N
6d0d3601-722b-4153-b310-a74ac720b986	\N	client-jwt	tyk	b58656b0-b4f5-4d11-b0c4-c29ac4d65c61	2	20	f	\N	\N
1059fd7c-18d1-4a04-8907-fbccb6bcc106	\N	client-secret-jwt	tyk	b58656b0-b4f5-4d11-b0c4-c29ac4d65c61	2	30	f	\N	\N
ec03f603-4cec-4b7d-bcaf-86574da848dc	\N	client-x509	tyk	b58656b0-b4f5-4d11-b0c4-c29ac4d65c61	2	40	f	\N	\N
c159fe6a-4648-4ca5-b4b1-bdc2c31473b3	\N	idp-review-profile	tyk	9e056332-7d14-4da7-ab89-ad75deb22478	0	10	f	\N	95dbbc36-a275-4b38-9f48-cf3722540af8
3fb9703c-1bf6-48a9-b283-8456ee5481db	\N	\N	tyk	9e056332-7d14-4da7-ab89-ad75deb22478	0	20	t	f8f5e759-326b-4ab8-90f7-9d8fd7055e87	\N
00eae790-e13a-49e2-9503-c116b67ee52c	\N	idp-create-user-if-unique	tyk	f8f5e759-326b-4ab8-90f7-9d8fd7055e87	2	10	f	\N	caba881b-784d-4fb8-80de-a85de69fd11a
69713d4f-888f-4f1a-8409-c03b3804c14b	\N	\N	tyk	f8f5e759-326b-4ab8-90f7-9d8fd7055e87	2	20	t	a16bab77-bb84-4298-ab62-eb14af17e94b	\N
1c4c10a9-e971-4883-a93b-e9e149ee9662	\N	idp-confirm-link	tyk	a16bab77-bb84-4298-ab62-eb14af17e94b	0	10	f	\N	\N
bd808c13-407c-4239-ab21-4cfbcbbd3dcb	\N	\N	tyk	a16bab77-bb84-4298-ab62-eb14af17e94b	0	20	t	3b202b48-a504-40ad-9963-48e9c4ee8717	\N
7c4ad325-0156-492a-ab27-07252aac6b63	\N	idp-email-verification	tyk	3b202b48-a504-40ad-9963-48e9c4ee8717	2	10	f	\N	\N
1b04d8f1-eb34-4d44-81b7-b974ee8fe317	\N	\N	tyk	3b202b48-a504-40ad-9963-48e9c4ee8717	2	20	t	20a9fdb7-2f65-4a6d-bba2-b40cde00db91	\N
094eee47-ebf3-45ea-a7b9-c5f2fed8cdf4	\N	idp-username-password-form	tyk	20a9fdb7-2f65-4a6d-bba2-b40cde00db91	0	10	f	\N	\N
7e9f4f50-2e0b-4db9-a9e3-2d12dca46993	\N	\N	tyk	20a9fdb7-2f65-4a6d-bba2-b40cde00db91	1	20	t	f0bd18d9-6ade-48fa-9f25-f90e93bed4b1	\N
a5de26fc-fc03-4628-b747-22df8d46965f	\N	conditional-user-configured	tyk	f0bd18d9-6ade-48fa-9f25-f90e93bed4b1	0	10	f	\N	\N
6e0f6894-9def-415b-a79e-762c6c705c26	\N	auth-otp-form	tyk	f0bd18d9-6ade-48fa-9f25-f90e93bed4b1	0	20	f	\N	\N
6220101e-4818-4f94-8a7c-769142e29fe3	\N	http-basic-authenticator	tyk	28d3406e-8544-4543-8c3c-1d2813923271	0	10	f	\N	\N
90860328-0588-41bb-a630-d58a97450cdd	\N	docker-http-basic-authenticator	tyk	a9cd90cf-b269-49fd-b098-3cc7712031b6	0	10	f	\N	\N
84cadd5d-8a29-44c7-8c73-cd4a04f0229c	\N	no-cookie-redirect	tyk	e121e26f-3460-4d6a-8f87-2361b6d690e1	0	10	f	\N	\N
6e7548e1-82fe-4173-8f58-bde143048985	\N	\N	tyk	e121e26f-3460-4d6a-8f87-2361b6d690e1	0	20	t	fded4cf9-6ba5-4acf-8e0a-016c3910b0dd	\N
cc59ad45-187c-479a-9d88-3cc7907c66d0	\N	basic-auth	tyk	fded4cf9-6ba5-4acf-8e0a-016c3910b0dd	0	10	f	\N	\N
95747964-2229-4a4c-93a7-1bccb259edcb	\N	basic-auth-otp	tyk	fded4cf9-6ba5-4acf-8e0a-016c3910b0dd	3	20	f	\N	\N
eadba965-0b52-42c2-a824-0b7d7c1c50bc	\N	auth-spnego	tyk	fded4cf9-6ba5-4acf-8e0a-016c3910b0dd	3	30	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
2759373b-ad08-4fae-bbf2-407d3be938ef	browser	browser based authentication	master	basic-flow	t	t
eb10930a-e894-4e0a-836b-966618d86961	forms	Username, password, otp and other auth forms.	master	basic-flow	f	t
b4b11980-7a11-4b98-b97f-96bc1736bc0a	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
12c2ea48-a47a-4aec-93ee-e0e76ebb1036	direct grant	OpenID Connect Resource Owner Grant	master	basic-flow	t	t
f15b7a6f-6f64-4317-b1a3-9610fb2ede5b	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
8c7ae44f-e177-4ff4-8638-0bde1a03f034	registration	registration flow	master	basic-flow	t	t
9633bd51-4d1c-4177-af4f-bef4b034a740	registration form	registration form	master	form-flow	f	t
710ce88b-7e48-4443-bc75-6261c48c129f	reset credentials	Reset credentials for a user if they forgot their password or something	master	basic-flow	t	t
5fb3df41-312c-4d2d-bf2b-777e32432460	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	master	basic-flow	f	t
dd1eb685-1e56-488a-a912-3134aa270089	clients	Base authentication for clients	master	client-flow	t	t
9e49be7e-6917-4df4-9b05-2e5c733ba904	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	master	basic-flow	t	t
bb38b33c-cc91-405f-ba64-cdd5b62f45a8	User creation or linking	Flow for the existing/non-existing user alternatives	master	basic-flow	f	t
3e558b6e-d972-44fd-a951-d898c57f7518	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	master	basic-flow	f	t
aac02fe2-7fa2-440f-8100-e34782168cf0	Account verification options	Method with which to verity the existing account	master	basic-flow	f	t
791d8293-2a61-43e6-a34a-9f89e0e6d240	Verify Existing Account by Re-authentication	Reauthentication of existing account	master	basic-flow	f	t
a76684d3-4c36-42b7-a7c0-e425e6826c85	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
10e6144c-0407-452f-8e0d-774a45e8ed4e	saml ecp	SAML ECP Profile Authentication Flow	master	basic-flow	t	t
0dca4dca-413a-4083-83da-b8c3474d18d8	docker auth	Used by Docker clients to authenticate against the IDP	master	basic-flow	t	t
99471bf6-8d82-4ae2-af91-696d78b3953c	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	master	basic-flow	t	t
fa53b7ba-88d3-4d51-aa3a-dc52688ca5ca	Authentication Options	Authentication options.	master	basic-flow	f	t
68e617f0-a3fa-4e54-b654-b5a7468de2dc	browser	browser based authentication	tyk	basic-flow	t	t
9cf6632f-d4fe-4799-8b26-d5b52dbf24af	forms	Username, password, otp and other auth forms.	tyk	basic-flow	f	t
4f226875-4e0a-4d8c-892c-04c66c8607f9	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	tyk	basic-flow	f	t
2164e41c-8c19-41c4-b7bd-2415c1e4c6e4	direct grant	OpenID Connect Resource Owner Grant	tyk	basic-flow	t	t
19e55f23-74c5-4190-8f5a-e588f559301b	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	tyk	basic-flow	f	t
1089f8d7-909b-4ca2-aef9-98c5905607be	registration	registration flow	tyk	basic-flow	t	t
a445fa7b-e338-4790-ac61-7fe89619048c	registration form	registration form	tyk	form-flow	f	t
e80e515d-05c2-4f19-a225-d266513980cf	reset credentials	Reset credentials for a user if they forgot their password or something	tyk	basic-flow	t	t
16cad86f-a560-4ce3-9773-09dc03da51e1	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	tyk	basic-flow	f	t
b58656b0-b4f5-4d11-b0c4-c29ac4d65c61	clients	Base authentication for clients	tyk	client-flow	t	t
9e056332-7d14-4da7-ab89-ad75deb22478	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	tyk	basic-flow	t	t
f8f5e759-326b-4ab8-90f7-9d8fd7055e87	User creation or linking	Flow for the existing/non-existing user alternatives	tyk	basic-flow	f	t
a16bab77-bb84-4298-ab62-eb14af17e94b	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	tyk	basic-flow	f	t
3b202b48-a504-40ad-9963-48e9c4ee8717	Account verification options	Method with which to verity the existing account	tyk	basic-flow	f	t
20a9fdb7-2f65-4a6d-bba2-b40cde00db91	Verify Existing Account by Re-authentication	Reauthentication of existing account	tyk	basic-flow	f	t
f0bd18d9-6ade-48fa-9f25-f90e93bed4b1	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	tyk	basic-flow	f	t
28d3406e-8544-4543-8c3c-1d2813923271	saml ecp	SAML ECP Profile Authentication Flow	tyk	basic-flow	t	t
a9cd90cf-b269-49fd-b098-3cc7712031b6	docker auth	Used by Docker clients to authenticate against the IDP	tyk	basic-flow	t	t
e121e26f-3460-4d6a-8f87-2361b6d690e1	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	tyk	basic-flow	t	t
fded4cf9-6ba5-4acf-8e0a-016c3910b0dd	Authentication Options	Authentication options.	tyk	basic-flow	f	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
8c8fd65f-9af9-41a7-8258-1334de3294b9	review profile config	master
26d250e0-a8a1-46d0-b246-46a07dc4e93a	create unique user config	master
95dbbc36-a275-4b38-9f48-cf3722540af8	review profile config	tyk
caba881b-784d-4fb8-80de-a85de69fd11a	create unique user config	tyk
222cf0dc-5ac5-44e4-a18b-f1e59ba36b38	Require password	tyk
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
8c8fd65f-9af9-41a7-8258-1334de3294b9	missing	update.profile.on.first.login
26d250e0-a8a1-46d0-b246-46a07dc4e93a	false	require.password.update.after.registration
95dbbc36-a275-4b38-9f48-cf3722540af8	missing	update.profile.on.first.login
caba881b-784d-4fb8-80de-a85de69fd11a	false	require.password.update.after.registration
222cf0dc-5ac5-44e4-a18b-f1e59ba36b38	true	require.password.update.after.registration
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
639adc27-e97e-45e9-92d1-1061133b4787	t	f	master-realm	0	f	\N	\N	t	\N	f	master	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
de00d1d1-50b2-45dd-982e-bc46453bb408	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
43a35051-12de-44fe-bef9-e3fdc2cc9d10	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
ba6e35ab-d52f-4d61-aaab-83928a145710	t	f	broker	0	f	\N	\N	t	\N	f	master	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
6d0f8f9f-cf55-434f-a092-ec69d984fe8e	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	master	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
a07f919e-b33e-4690-a07c-d8c037f371d5	t	f	admin-cli	0	t	\N	\N	f	\N	f	master	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
67575c50-2f33-4c82-8db8-65804d8fd5ba	t	f	tyk-realm	0	f	\N	\N	t	\N	f	master	\N	0	f	f	tyk Realm	f	client-secret	\N	\N	\N	t	f	f	f
c161713b-d494-4973-abbe-8bf73547f655	t	f	realm-management	0	f	\N	\N	t	\N	f	tyk	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
e09542b3-c0dc-47cd-9188-1af7d04a87eb	t	f	account	0	t	\N	/realms/tyk/account/	f	\N	f	tyk	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
66d4945b-46e4-4841-8984-3411b9c64288	t	f	account-console	0	t	\N	/realms/tyk/account/	f	\N	f	tyk	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
efb5ef39-2a2c-4313-b1f1-578e7061ba28	t	f	broker	0	f	\N	\N	t	\N	f	tyk	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
ee928f89-93ce-4ca2-91db-e640b8f60fde	t	f	security-admin-console	0	t	\N	/admin/tyk/console/	f	\N	f	tyk	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
126a5458-adb4-4417-8402-596d1a2272bc	t	f	admin-cli	0	t	\N	\N	f	\N	f	tyk	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
5cb3b129-c24d-40f4-9bcb-191266ed00e0	t	t	tyk-gateway	0	f	9CkkSHVW5IBjS8iOdN8BYtjMJ9j2wM2T	\N	f	\N	f	tyk	openid-connect	-1	f	f	\N	t	client-secret	\N	\N	\N	t	f	t	f
ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	t	t	tyk-client	0	f	3cIddz8JHCByQDyMYXtOTuyaDvO9y39j	https://micare.ml	f	\N	f	tyk	openid-connect	-1	f	f	\N	t	client-secret	\N	\N	\N	t	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_attributes (client_id, value, name) FROM stdin;
43a35051-12de-44fe-bef9-e3fdc2cc9d10	S256	pkce.code.challenge.method
6d0f8f9f-cf55-434f-a092-ec69d984fe8e	S256	pkce.code.challenge.method
66d4945b-46e4-4841-8984-3411b9c64288	S256	pkce.code.challenge.method
ee928f89-93ce-4ca2-91db-e640b8f60fde	S256	pkce.code.challenge.method
5cb3b129-c24d-40f4-9bcb-191266ed00e0	true	backchannel.logout.session.required
5cb3b129-c24d-40f4-9bcb-191266ed00e0	false	backchannel.logout.revoke.offline.tokens
5cb3b129-c24d-40f4-9bcb-191266ed00e0	false	saml.artifact.binding
5cb3b129-c24d-40f4-9bcb-191266ed00e0	false	saml.server.signature
5cb3b129-c24d-40f4-9bcb-191266ed00e0	false	saml.server.signature.keyinfo.ext
5cb3b129-c24d-40f4-9bcb-191266ed00e0	false	saml.assertion.signature
5cb3b129-c24d-40f4-9bcb-191266ed00e0	false	saml.client.signature
5cb3b129-c24d-40f4-9bcb-191266ed00e0	false	saml.encrypt
5cb3b129-c24d-40f4-9bcb-191266ed00e0	false	saml.authnstatement
5cb3b129-c24d-40f4-9bcb-191266ed00e0	false	saml.onetimeuse.condition
5cb3b129-c24d-40f4-9bcb-191266ed00e0	false	saml_force_name_id_format
5cb3b129-c24d-40f4-9bcb-191266ed00e0	false	saml.multivalued.roles
5cb3b129-c24d-40f4-9bcb-191266ed00e0	false	saml.force.post.binding
5cb3b129-c24d-40f4-9bcb-191266ed00e0	false	exclude.session.state.from.auth.response
5cb3b129-c24d-40f4-9bcb-191266ed00e0	false	oauth2.device.authorization.grant.enabled
5cb3b129-c24d-40f4-9bcb-191266ed00e0	false	oidc.ciba.grant.enabled
5cb3b129-c24d-40f4-9bcb-191266ed00e0	true	use.refresh.tokens
5cb3b129-c24d-40f4-9bcb-191266ed00e0	false	id.token.as.detached.signature
5cb3b129-c24d-40f4-9bcb-191266ed00e0	false	tls.client.certificate.bound.access.tokens
5cb3b129-c24d-40f4-9bcb-191266ed00e0	false	require.pushed.authorization.requests
5cb3b129-c24d-40f4-9bcb-191266ed00e0	false	client_credentials.use_refresh_token
5cb3b129-c24d-40f4-9bcb-191266ed00e0	false	display.on.consent.screen
ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	true	backchannel.logout.session.required
ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	false	backchannel.logout.revoke.offline.tokens
ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	false	saml.artifact.binding
ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	false	saml.server.signature
ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	false	saml.server.signature.keyinfo.ext
ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	false	saml.assertion.signature
ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	false	saml.client.signature
ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	false	saml.encrypt
ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	false	saml.authnstatement
ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	false	saml.onetimeuse.condition
ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	false	saml_force_name_id_format
ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	false	saml.multivalued.roles
ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	false	saml.force.post.binding
ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	false	exclude.session.state.from.auth.response
ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	false	oauth2.device.authorization.grant.enabled
ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	false	oidc.ciba.grant.enabled
ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	true	use.refresh.tokens
ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	false	id.token.as.detached.signature
ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	false	tls.client.certificate.bound.access.tokens
ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	false	require.pushed.authorization.requests
ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	false	client_credentials.use_refresh_token
ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	false	display.on.consent.screen
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
915b86d6-b332-465f-8fa9-ba5b418a99f9	offline_access	master	OpenID Connect built-in scope: offline_access	openid-connect
59cc55a2-6546-4336-a1ab-912f67a2c6fc	role_list	master	SAML role list	saml
90cf12ed-750a-4662-bd69-6b864b05ace2	profile	master	OpenID Connect built-in scope: profile	openid-connect
d0f8c9a9-c788-45f4-ac56-d7e64d8f93ea	email	master	OpenID Connect built-in scope: email	openid-connect
502ac439-8ff9-453e-ba29-9a4237570961	address	master	OpenID Connect built-in scope: address	openid-connect
393ea3e6-e9d9-4342-a7d3-adaf4dc1d3f1	phone	master	OpenID Connect built-in scope: phone	openid-connect
3e636212-b475-4639-800d-f470e5d3591f	roles	master	OpenID Connect scope for add user roles to the access token	openid-connect
601f8f6b-6716-46a6-9876-f8cc3819219c	web-origins	master	OpenID Connect scope for add allowed web origins to the access token	openid-connect
da1516d1-22e7-4e0f-adc0-2c5400dd469e	microprofile-jwt	master	Microprofile - JWT built-in scope	openid-connect
8b8b9069-4f66-4136-8a89-ff8b692f447d	offline_access	tyk	OpenID Connect built-in scope: offline_access	openid-connect
0f6adf9b-de50-4b7e-af5a-460645696fa3	role_list	tyk	SAML role list	saml
e6381ff1-96dd-44a3-838e-29f2744ac2c2	profile	tyk	OpenID Connect built-in scope: profile	openid-connect
588e3a10-afd5-4ab5-a94f-3e32b5be0df3	email	tyk	OpenID Connect built-in scope: email	openid-connect
11da0f80-a834-438b-9b17-f4ef6fab7a87	address	tyk	OpenID Connect built-in scope: address	openid-connect
a2536b85-7768-4c18-9d45-276565311401	phone	tyk	OpenID Connect built-in scope: phone	openid-connect
7ce2e83c-42a1-42cb-bdc7-6857083d9170	web-origins	tyk	OpenID Connect scope for add allowed web origins to the access token	openid-connect
5906659a-867d-46e2-8fc3-b81eab6489c3	microprofile-jwt	tyk	Microprofile - JWT built-in scope	openid-connect
850092e2-1349-4254-af96-89013593e113	role	tyk	OpenID Connect scope for add user roles to the access token	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
915b86d6-b332-465f-8fa9-ba5b418a99f9	true	display.on.consent.screen
915b86d6-b332-465f-8fa9-ba5b418a99f9	${offlineAccessScopeConsentText}	consent.screen.text
59cc55a2-6546-4336-a1ab-912f67a2c6fc	true	display.on.consent.screen
59cc55a2-6546-4336-a1ab-912f67a2c6fc	${samlRoleListScopeConsentText}	consent.screen.text
90cf12ed-750a-4662-bd69-6b864b05ace2	true	display.on.consent.screen
90cf12ed-750a-4662-bd69-6b864b05ace2	${profileScopeConsentText}	consent.screen.text
90cf12ed-750a-4662-bd69-6b864b05ace2	true	include.in.token.scope
d0f8c9a9-c788-45f4-ac56-d7e64d8f93ea	true	display.on.consent.screen
d0f8c9a9-c788-45f4-ac56-d7e64d8f93ea	${emailScopeConsentText}	consent.screen.text
d0f8c9a9-c788-45f4-ac56-d7e64d8f93ea	true	include.in.token.scope
502ac439-8ff9-453e-ba29-9a4237570961	true	display.on.consent.screen
502ac439-8ff9-453e-ba29-9a4237570961	${addressScopeConsentText}	consent.screen.text
502ac439-8ff9-453e-ba29-9a4237570961	true	include.in.token.scope
393ea3e6-e9d9-4342-a7d3-adaf4dc1d3f1	true	display.on.consent.screen
393ea3e6-e9d9-4342-a7d3-adaf4dc1d3f1	${phoneScopeConsentText}	consent.screen.text
393ea3e6-e9d9-4342-a7d3-adaf4dc1d3f1	true	include.in.token.scope
3e636212-b475-4639-800d-f470e5d3591f	true	display.on.consent.screen
3e636212-b475-4639-800d-f470e5d3591f	${rolesScopeConsentText}	consent.screen.text
3e636212-b475-4639-800d-f470e5d3591f	false	include.in.token.scope
601f8f6b-6716-46a6-9876-f8cc3819219c	false	display.on.consent.screen
601f8f6b-6716-46a6-9876-f8cc3819219c		consent.screen.text
601f8f6b-6716-46a6-9876-f8cc3819219c	false	include.in.token.scope
da1516d1-22e7-4e0f-adc0-2c5400dd469e	false	display.on.consent.screen
da1516d1-22e7-4e0f-adc0-2c5400dd469e	true	include.in.token.scope
8b8b9069-4f66-4136-8a89-ff8b692f447d	true	display.on.consent.screen
8b8b9069-4f66-4136-8a89-ff8b692f447d	${offlineAccessScopeConsentText}	consent.screen.text
0f6adf9b-de50-4b7e-af5a-460645696fa3	true	display.on.consent.screen
0f6adf9b-de50-4b7e-af5a-460645696fa3	${samlRoleListScopeConsentText}	consent.screen.text
e6381ff1-96dd-44a3-838e-29f2744ac2c2	true	display.on.consent.screen
e6381ff1-96dd-44a3-838e-29f2744ac2c2	${profileScopeConsentText}	consent.screen.text
e6381ff1-96dd-44a3-838e-29f2744ac2c2	true	include.in.token.scope
588e3a10-afd5-4ab5-a94f-3e32b5be0df3	true	display.on.consent.screen
588e3a10-afd5-4ab5-a94f-3e32b5be0df3	${emailScopeConsentText}	consent.screen.text
588e3a10-afd5-4ab5-a94f-3e32b5be0df3	true	include.in.token.scope
11da0f80-a834-438b-9b17-f4ef6fab7a87	true	display.on.consent.screen
11da0f80-a834-438b-9b17-f4ef6fab7a87	${addressScopeConsentText}	consent.screen.text
11da0f80-a834-438b-9b17-f4ef6fab7a87	true	include.in.token.scope
a2536b85-7768-4c18-9d45-276565311401	true	display.on.consent.screen
a2536b85-7768-4c18-9d45-276565311401	${phoneScopeConsentText}	consent.screen.text
a2536b85-7768-4c18-9d45-276565311401	true	include.in.token.scope
850092e2-1349-4254-af96-89013593e113	true	display.on.consent.screen
850092e2-1349-4254-af96-89013593e113	${rolesScopeConsentText}	consent.screen.text
850092e2-1349-4254-af96-89013593e113	false	include.in.token.scope
7ce2e83c-42a1-42cb-bdc7-6857083d9170	false	display.on.consent.screen
7ce2e83c-42a1-42cb-bdc7-6857083d9170		consent.screen.text
7ce2e83c-42a1-42cb-bdc7-6857083d9170	false	include.in.token.scope
5906659a-867d-46e2-8fc3-b81eab6489c3	false	display.on.consent.screen
5906659a-867d-46e2-8fc3-b81eab6489c3	true	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
de00d1d1-50b2-45dd-982e-bc46453bb408	3e636212-b475-4639-800d-f470e5d3591f	t
de00d1d1-50b2-45dd-982e-bc46453bb408	d0f8c9a9-c788-45f4-ac56-d7e64d8f93ea	t
de00d1d1-50b2-45dd-982e-bc46453bb408	90cf12ed-750a-4662-bd69-6b864b05ace2	t
de00d1d1-50b2-45dd-982e-bc46453bb408	601f8f6b-6716-46a6-9876-f8cc3819219c	t
de00d1d1-50b2-45dd-982e-bc46453bb408	502ac439-8ff9-453e-ba29-9a4237570961	f
de00d1d1-50b2-45dd-982e-bc46453bb408	915b86d6-b332-465f-8fa9-ba5b418a99f9	f
de00d1d1-50b2-45dd-982e-bc46453bb408	393ea3e6-e9d9-4342-a7d3-adaf4dc1d3f1	f
de00d1d1-50b2-45dd-982e-bc46453bb408	da1516d1-22e7-4e0f-adc0-2c5400dd469e	f
43a35051-12de-44fe-bef9-e3fdc2cc9d10	3e636212-b475-4639-800d-f470e5d3591f	t
43a35051-12de-44fe-bef9-e3fdc2cc9d10	d0f8c9a9-c788-45f4-ac56-d7e64d8f93ea	t
43a35051-12de-44fe-bef9-e3fdc2cc9d10	90cf12ed-750a-4662-bd69-6b864b05ace2	t
43a35051-12de-44fe-bef9-e3fdc2cc9d10	601f8f6b-6716-46a6-9876-f8cc3819219c	t
43a35051-12de-44fe-bef9-e3fdc2cc9d10	502ac439-8ff9-453e-ba29-9a4237570961	f
43a35051-12de-44fe-bef9-e3fdc2cc9d10	915b86d6-b332-465f-8fa9-ba5b418a99f9	f
43a35051-12de-44fe-bef9-e3fdc2cc9d10	393ea3e6-e9d9-4342-a7d3-adaf4dc1d3f1	f
43a35051-12de-44fe-bef9-e3fdc2cc9d10	da1516d1-22e7-4e0f-adc0-2c5400dd469e	f
a07f919e-b33e-4690-a07c-d8c037f371d5	3e636212-b475-4639-800d-f470e5d3591f	t
a07f919e-b33e-4690-a07c-d8c037f371d5	d0f8c9a9-c788-45f4-ac56-d7e64d8f93ea	t
a07f919e-b33e-4690-a07c-d8c037f371d5	90cf12ed-750a-4662-bd69-6b864b05ace2	t
a07f919e-b33e-4690-a07c-d8c037f371d5	601f8f6b-6716-46a6-9876-f8cc3819219c	t
a07f919e-b33e-4690-a07c-d8c037f371d5	502ac439-8ff9-453e-ba29-9a4237570961	f
a07f919e-b33e-4690-a07c-d8c037f371d5	915b86d6-b332-465f-8fa9-ba5b418a99f9	f
a07f919e-b33e-4690-a07c-d8c037f371d5	393ea3e6-e9d9-4342-a7d3-adaf4dc1d3f1	f
a07f919e-b33e-4690-a07c-d8c037f371d5	da1516d1-22e7-4e0f-adc0-2c5400dd469e	f
ba6e35ab-d52f-4d61-aaab-83928a145710	3e636212-b475-4639-800d-f470e5d3591f	t
ba6e35ab-d52f-4d61-aaab-83928a145710	d0f8c9a9-c788-45f4-ac56-d7e64d8f93ea	t
ba6e35ab-d52f-4d61-aaab-83928a145710	90cf12ed-750a-4662-bd69-6b864b05ace2	t
ba6e35ab-d52f-4d61-aaab-83928a145710	601f8f6b-6716-46a6-9876-f8cc3819219c	t
ba6e35ab-d52f-4d61-aaab-83928a145710	502ac439-8ff9-453e-ba29-9a4237570961	f
ba6e35ab-d52f-4d61-aaab-83928a145710	915b86d6-b332-465f-8fa9-ba5b418a99f9	f
ba6e35ab-d52f-4d61-aaab-83928a145710	393ea3e6-e9d9-4342-a7d3-adaf4dc1d3f1	f
ba6e35ab-d52f-4d61-aaab-83928a145710	da1516d1-22e7-4e0f-adc0-2c5400dd469e	f
639adc27-e97e-45e9-92d1-1061133b4787	3e636212-b475-4639-800d-f470e5d3591f	t
639adc27-e97e-45e9-92d1-1061133b4787	d0f8c9a9-c788-45f4-ac56-d7e64d8f93ea	t
639adc27-e97e-45e9-92d1-1061133b4787	90cf12ed-750a-4662-bd69-6b864b05ace2	t
639adc27-e97e-45e9-92d1-1061133b4787	601f8f6b-6716-46a6-9876-f8cc3819219c	t
639adc27-e97e-45e9-92d1-1061133b4787	502ac439-8ff9-453e-ba29-9a4237570961	f
639adc27-e97e-45e9-92d1-1061133b4787	915b86d6-b332-465f-8fa9-ba5b418a99f9	f
639adc27-e97e-45e9-92d1-1061133b4787	393ea3e6-e9d9-4342-a7d3-adaf4dc1d3f1	f
639adc27-e97e-45e9-92d1-1061133b4787	da1516d1-22e7-4e0f-adc0-2c5400dd469e	f
6d0f8f9f-cf55-434f-a092-ec69d984fe8e	3e636212-b475-4639-800d-f470e5d3591f	t
6d0f8f9f-cf55-434f-a092-ec69d984fe8e	d0f8c9a9-c788-45f4-ac56-d7e64d8f93ea	t
6d0f8f9f-cf55-434f-a092-ec69d984fe8e	90cf12ed-750a-4662-bd69-6b864b05ace2	t
6d0f8f9f-cf55-434f-a092-ec69d984fe8e	601f8f6b-6716-46a6-9876-f8cc3819219c	t
6d0f8f9f-cf55-434f-a092-ec69d984fe8e	502ac439-8ff9-453e-ba29-9a4237570961	f
6d0f8f9f-cf55-434f-a092-ec69d984fe8e	915b86d6-b332-465f-8fa9-ba5b418a99f9	f
6d0f8f9f-cf55-434f-a092-ec69d984fe8e	393ea3e6-e9d9-4342-a7d3-adaf4dc1d3f1	f
6d0f8f9f-cf55-434f-a092-ec69d984fe8e	da1516d1-22e7-4e0f-adc0-2c5400dd469e	f
e09542b3-c0dc-47cd-9188-1af7d04a87eb	e6381ff1-96dd-44a3-838e-29f2744ac2c2	t
e09542b3-c0dc-47cd-9188-1af7d04a87eb	7ce2e83c-42a1-42cb-bdc7-6857083d9170	t
e09542b3-c0dc-47cd-9188-1af7d04a87eb	850092e2-1349-4254-af96-89013593e113	t
e09542b3-c0dc-47cd-9188-1af7d04a87eb	588e3a10-afd5-4ab5-a94f-3e32b5be0df3	t
e09542b3-c0dc-47cd-9188-1af7d04a87eb	5906659a-867d-46e2-8fc3-b81eab6489c3	f
e09542b3-c0dc-47cd-9188-1af7d04a87eb	8b8b9069-4f66-4136-8a89-ff8b692f447d	f
66d4945b-46e4-4841-8984-3411b9c64288	e6381ff1-96dd-44a3-838e-29f2744ac2c2	t
66d4945b-46e4-4841-8984-3411b9c64288	7ce2e83c-42a1-42cb-bdc7-6857083d9170	t
66d4945b-46e4-4841-8984-3411b9c64288	850092e2-1349-4254-af96-89013593e113	t
66d4945b-46e4-4841-8984-3411b9c64288	588e3a10-afd5-4ab5-a94f-3e32b5be0df3	t
66d4945b-46e4-4841-8984-3411b9c64288	5906659a-867d-46e2-8fc3-b81eab6489c3	f
66d4945b-46e4-4841-8984-3411b9c64288	8b8b9069-4f66-4136-8a89-ff8b692f447d	f
66d4945b-46e4-4841-8984-3411b9c64288	a2536b85-7768-4c18-9d45-276565311401	f
66d4945b-46e4-4841-8984-3411b9c64288	11da0f80-a834-438b-9b17-f4ef6fab7a87	f
126a5458-adb4-4417-8402-596d1a2272bc	e6381ff1-96dd-44a3-838e-29f2744ac2c2	t
126a5458-adb4-4417-8402-596d1a2272bc	7ce2e83c-42a1-42cb-bdc7-6857083d9170	t
126a5458-adb4-4417-8402-596d1a2272bc	850092e2-1349-4254-af96-89013593e113	t
126a5458-adb4-4417-8402-596d1a2272bc	588e3a10-afd5-4ab5-a94f-3e32b5be0df3	t
126a5458-adb4-4417-8402-596d1a2272bc	5906659a-867d-46e2-8fc3-b81eab6489c3	f
126a5458-adb4-4417-8402-596d1a2272bc	8b8b9069-4f66-4136-8a89-ff8b692f447d	f
126a5458-adb4-4417-8402-596d1a2272bc	a2536b85-7768-4c18-9d45-276565311401	f
126a5458-adb4-4417-8402-596d1a2272bc	11da0f80-a834-438b-9b17-f4ef6fab7a87	f
efb5ef39-2a2c-4313-b1f1-578e7061ba28	e6381ff1-96dd-44a3-838e-29f2744ac2c2	t
efb5ef39-2a2c-4313-b1f1-578e7061ba28	7ce2e83c-42a1-42cb-bdc7-6857083d9170	t
efb5ef39-2a2c-4313-b1f1-578e7061ba28	850092e2-1349-4254-af96-89013593e113	t
efb5ef39-2a2c-4313-b1f1-578e7061ba28	588e3a10-afd5-4ab5-a94f-3e32b5be0df3	t
efb5ef39-2a2c-4313-b1f1-578e7061ba28	5906659a-867d-46e2-8fc3-b81eab6489c3	f
efb5ef39-2a2c-4313-b1f1-578e7061ba28	8b8b9069-4f66-4136-8a89-ff8b692f447d	f
efb5ef39-2a2c-4313-b1f1-578e7061ba28	a2536b85-7768-4c18-9d45-276565311401	f
efb5ef39-2a2c-4313-b1f1-578e7061ba28	11da0f80-a834-438b-9b17-f4ef6fab7a87	f
c161713b-d494-4973-abbe-8bf73547f655	e6381ff1-96dd-44a3-838e-29f2744ac2c2	t
c161713b-d494-4973-abbe-8bf73547f655	7ce2e83c-42a1-42cb-bdc7-6857083d9170	t
c161713b-d494-4973-abbe-8bf73547f655	850092e2-1349-4254-af96-89013593e113	t
c161713b-d494-4973-abbe-8bf73547f655	588e3a10-afd5-4ab5-a94f-3e32b5be0df3	t
c161713b-d494-4973-abbe-8bf73547f655	5906659a-867d-46e2-8fc3-b81eab6489c3	f
c161713b-d494-4973-abbe-8bf73547f655	8b8b9069-4f66-4136-8a89-ff8b692f447d	f
c161713b-d494-4973-abbe-8bf73547f655	a2536b85-7768-4c18-9d45-276565311401	f
c161713b-d494-4973-abbe-8bf73547f655	11da0f80-a834-438b-9b17-f4ef6fab7a87	f
ee928f89-93ce-4ca2-91db-e640b8f60fde	e6381ff1-96dd-44a3-838e-29f2744ac2c2	t
ee928f89-93ce-4ca2-91db-e640b8f60fde	7ce2e83c-42a1-42cb-bdc7-6857083d9170	t
ee928f89-93ce-4ca2-91db-e640b8f60fde	850092e2-1349-4254-af96-89013593e113	t
ee928f89-93ce-4ca2-91db-e640b8f60fde	588e3a10-afd5-4ab5-a94f-3e32b5be0df3	t
ee928f89-93ce-4ca2-91db-e640b8f60fde	5906659a-867d-46e2-8fc3-b81eab6489c3	f
ee928f89-93ce-4ca2-91db-e640b8f60fde	8b8b9069-4f66-4136-8a89-ff8b692f447d	f
ee928f89-93ce-4ca2-91db-e640b8f60fde	a2536b85-7768-4c18-9d45-276565311401	f
ee928f89-93ce-4ca2-91db-e640b8f60fde	11da0f80-a834-438b-9b17-f4ef6fab7a87	f
5cb3b129-c24d-40f4-9bcb-191266ed00e0	e6381ff1-96dd-44a3-838e-29f2744ac2c2	t
5cb3b129-c24d-40f4-9bcb-191266ed00e0	7ce2e83c-42a1-42cb-bdc7-6857083d9170	t
5cb3b129-c24d-40f4-9bcb-191266ed00e0	850092e2-1349-4254-af96-89013593e113	t
5cb3b129-c24d-40f4-9bcb-191266ed00e0	588e3a10-afd5-4ab5-a94f-3e32b5be0df3	t
5cb3b129-c24d-40f4-9bcb-191266ed00e0	5906659a-867d-46e2-8fc3-b81eab6489c3	f
5cb3b129-c24d-40f4-9bcb-191266ed00e0	8b8b9069-4f66-4136-8a89-ff8b692f447d	f
5cb3b129-c24d-40f4-9bcb-191266ed00e0	a2536b85-7768-4c18-9d45-276565311401	f
5cb3b129-c24d-40f4-9bcb-191266ed00e0	11da0f80-a834-438b-9b17-f4ef6fab7a87	f
ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	e6381ff1-96dd-44a3-838e-29f2744ac2c2	t
ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	7ce2e83c-42a1-42cb-bdc7-6857083d9170	t
ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	850092e2-1349-4254-af96-89013593e113	t
ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	588e3a10-afd5-4ab5-a94f-3e32b5be0df3	t
ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	5906659a-867d-46e2-8fc3-b81eab6489c3	f
ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	8b8b9069-4f66-4136-8a89-ff8b692f447d	f
e09542b3-c0dc-47cd-9188-1af7d04a87eb	11da0f80-a834-438b-9b17-f4ef6fab7a87	t
e09542b3-c0dc-47cd-9188-1af7d04a87eb	a2536b85-7768-4c18-9d45-276565311401	t
ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	11da0f80-a834-438b-9b17-f4ef6fab7a87	t
ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	a2536b85-7768-4c18-9d45-276565311401	t
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
915b86d6-b332-465f-8fa9-ba5b418a99f9	0e32413c-2b78-4863-9739-ab50d688a817
8b8b9069-4f66-4136-8a89-ff8b692f447d	cbdcaeb0-642f-4fc2-bc03-b45abd7cc0aa
a2536b85-7768-4c18-9d45-276565311401	b9e0c4ab-5749-44c4-88a4-1af8f7915634
11da0f80-a834-438b-9b17-f4ef6fab7a87	b9e0c4ab-5749-44c4-88a4-1af8f7915634
588e3a10-afd5-4ab5-a94f-3e32b5be0df3	b9e0c4ab-5749-44c4-88a4-1af8f7915634
a2536b85-7768-4c18-9d45-276565311401	756e1230-3bd7-4940-9aac-d5045f83b88f
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
8e7cc02b-23f2-4680-8e95-fd667c31b5a4	Trusted Hosts	master	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
13ce8883-3091-4ce4-9ef2-e32b295ff85a	Consent Required	master	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
00dece38-fd0d-4425-baa9-f244d3b9300a	Full Scope Disabled	master	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
6f074882-32d9-401c-a45d-d0ed87f9e7fa	Max Clients Limit	master	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
f5cc3d37-533a-4ff4-8558-503f9fcecc87	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
ce7a04c1-4e5e-4cb6-9ff1-96cf35107f04	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
a025399c-b59b-4872-bca4-0dcffb343274	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
3bfa8700-c555-4717-b727-53f19e44ee70	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
fc74b35e-856a-4b39-9362-3ba874a07ff6	rsa-generated	master	rsa-generated	org.keycloak.keys.KeyProvider	master	\N
11caf43d-e86e-4968-97a4-fee48f9b804c	rsa-enc-generated	master	rsa-enc-generated	org.keycloak.keys.KeyProvider	master	\N
0446adca-d69c-451c-a113-58f8eda6e19d	hmac-generated	master	hmac-generated	org.keycloak.keys.KeyProvider	master	\N
056f8219-7d76-4731-bd8d-8662b7e9f12d	aes-generated	master	aes-generated	org.keycloak.keys.KeyProvider	master	\N
509a3de5-1808-4aa5-83c1-059ccac02d89	rsa-generated	tyk	rsa-generated	org.keycloak.keys.KeyProvider	tyk	\N
2a043b43-ca0b-4add-878e-2b6a2997463c	rsa-enc-generated	tyk	rsa-enc-generated	org.keycloak.keys.KeyProvider	tyk	\N
70d2a049-52f1-4305-8753-9ee0c6c73672	hmac-generated	tyk	hmac-generated	org.keycloak.keys.KeyProvider	tyk	\N
980c33f7-2719-4d31-a9c5-7a2961edd87e	aes-generated	tyk	aes-generated	org.keycloak.keys.KeyProvider	tyk	\N
d403fc8c-c3a1-4d2d-8292-6422e32101e9	Trusted Hosts	tyk	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	tyk	anonymous
9cab8f2f-af27-4049-adb5-d815e4f60817	Consent Required	tyk	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	tyk	anonymous
33d59227-484a-4a8e-991c-f9d34f5e8f24	Full Scope Disabled	tyk	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	tyk	anonymous
8a86a6fc-99ee-4938-ad2e-1d24ed9cc9ab	Max Clients Limit	tyk	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	tyk	anonymous
712f9c9f-5835-4d2b-a39e-f6f0973485d4	Allowed Protocol Mapper Types	tyk	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	tyk	anonymous
a0dde884-ae4b-4c25-b86f-302bb453bded	Allowed Client Scopes	tyk	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	tyk	anonymous
e6eddfaa-1057-4074-b8f5-7084dd09c5e7	Allowed Protocol Mapper Types	tyk	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	tyk	authenticated
325902d1-d525-4c31-ac44-61105ade18ab	Allowed Client Scopes	tyk	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	tyk	authenticated
4145476a-9376-4eb7-a785-1a5f17f82811	\N	tyk	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	tyk	\N
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
594588f9-6f9e-4848-8ccc-9982eb4ffee5	6f074882-32d9-401c-a45d-d0ed87f9e7fa	max-clients	200
1be1de70-0f79-43ad-a2d8-e60dc347bb3a	a025399c-b59b-4872-bca4-0dcffb343274	allowed-protocol-mapper-types	saml-user-attribute-mapper
4f87470f-7a88-4d3b-ba34-d520ac6eb23c	a025399c-b59b-4872-bca4-0dcffb343274	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
6896daa9-e07d-44f0-ab26-493476de4d83	a025399c-b59b-4872-bca4-0dcffb343274	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
28f14783-cfc5-438f-9b4d-d1d79d537ef3	a025399c-b59b-4872-bca4-0dcffb343274	allowed-protocol-mapper-types	oidc-address-mapper
779de92f-629a-4e12-9c50-042e06ee05ea	a025399c-b59b-4872-bca4-0dcffb343274	allowed-protocol-mapper-types	saml-role-list-mapper
4816f22d-d8d1-43e4-8cbf-885e09d027e3	a025399c-b59b-4872-bca4-0dcffb343274	allowed-protocol-mapper-types	oidc-full-name-mapper
4c591f39-33c0-44a0-8f15-c340d5aec162	a025399c-b59b-4872-bca4-0dcffb343274	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
202e2452-7080-4376-8972-079b97faa401	a025399c-b59b-4872-bca4-0dcffb343274	allowed-protocol-mapper-types	saml-user-property-mapper
6aa074b5-299a-42c0-8688-a28f5d23a4c8	8e7cc02b-23f2-4680-8e95-fd667c31b5a4	host-sending-registration-request-must-match	true
42dbf89d-c970-4792-8f4e-f8b080781b0d	8e7cc02b-23f2-4680-8e95-fd667c31b5a4	client-uris-must-match	true
41da1c24-69ca-44e1-83ff-31b53720a40f	3bfa8700-c555-4717-b727-53f19e44ee70	allow-default-scopes	true
b6a2e060-493c-46bb-8fc0-0a3de8419d1c	f5cc3d37-533a-4ff4-8558-503f9fcecc87	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
f01265e8-f869-4ef7-9c1f-bf235d0e2365	f5cc3d37-533a-4ff4-8558-503f9fcecc87	allowed-protocol-mapper-types	saml-user-attribute-mapper
9aeda320-5a8b-4839-93d1-1eb51e0ff631	f5cc3d37-533a-4ff4-8558-503f9fcecc87	allowed-protocol-mapper-types	oidc-full-name-mapper
de827ca7-ae46-4f9b-ad64-efe2e074cc89	f5cc3d37-533a-4ff4-8558-503f9fcecc87	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
6400fa5c-b185-4d96-aa4c-e8148b8793da	f5cc3d37-533a-4ff4-8558-503f9fcecc87	allowed-protocol-mapper-types	saml-user-property-mapper
b9891b21-5b89-4416-a003-eb9521cae86b	f5cc3d37-533a-4ff4-8558-503f9fcecc87	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
e8e1b5ac-3017-494a-a977-a637cf4d5775	f5cc3d37-533a-4ff4-8558-503f9fcecc87	allowed-protocol-mapper-types	saml-role-list-mapper
7162008a-2066-4d58-a6d2-c37a7e9f49c5	f5cc3d37-533a-4ff4-8558-503f9fcecc87	allowed-protocol-mapper-types	oidc-address-mapper
89f7f59e-aa6a-40fc-9e26-a1cbab8aeac8	ce7a04c1-4e5e-4cb6-9ff1-96cf35107f04	allow-default-scopes	true
85ebf9d6-bde7-4fd2-869f-9cd48c8a0f43	fc74b35e-856a-4b39-9362-3ba874a07ff6	privateKey	MIIEowIBAAKCAQEAr3/bZgpzHMm8l3PXclVG+MkHF+VPW8etJgP1DQFkt4bTTK3cwM/bRN3RdB7Tei4dCxp7IqWs4KCRC6NAlCUnI19k1ceFIw5nLuNM+veM8t0CCkr6sHUDE1+6vGDQTz/fPrec3H+0NogT2yBL6jrrSG61pkbRZxQMsspVsrP7A6n2pNF52i2+UWjVs/QR/zjR1YQaDVVtKqzEC/KFWXsLKVSECuGtahUXHHkFG6A2WfqBE6YvOye/gQPXWB7+GCY0KNiRMtfwyLt3sndGOemVchsQk+7vTBHIKLzzeNXj3FXBeVyojy6Ap6pwiAxNgCjajZ4i/X5YCNHGLtgh0P2ImQIDAQABAoIBAFnipF5I79hIwtzXKfuXDbiSTZ3Bhrm9NUOJN1Mn6YvN9B8L1UqzqtxEt+g/eZTUVW/Aaly+eiK6Wk+Zl5PIy5jkXOLZQ6lG0TZEmMLZU0l4RHk9GdSSubaMizm8ZDSSxCZ9KEwO5CAh5fmPOxKGhsccXNEC6HFg5XgVBXt3jxK6eyI9DfUmyuiDCwErG8CwLS3IT+8+HKm+mcEoq56f1UpDkVlRK+unZgS6igWNqvUMbAwVduaBFrh4R0lstuY1LyNF2JFBlFb6Pts4SWfRceTIdfLdgbPUkebhVUAx0YFsoPy8bY6X1p2HCKywYJ6+mXPp7WAsFoudIEJx7N6B8QECgYEA29GlljQAhlGD1TsA4XsqJH27HHtp6ZS4oQoA/gd/kOMebSohtj3ZhN4SPO8oQZyFwU9K/cHNY8RaDJrvP0o3Kc/koEECdOAeAQsCXDyCJ9L/t52D5UL8hSIIwNULFqT8qz6G8arcSqGagL5BvXfHi6cioZqBXR77J13Ha+fpr2kCgYEAzGLAYYEipcjYTKG4xtdH+GvNN8fm4K3cjwEhvTN6vQ2wvvcP0tUj5nkIJK+HftcOY7kt2i2mV5N8gY4Jr2/lJVe9iHb/Adh81mOtMd0bFiQJ5FLvWA/113J9veCtFwyPkb4UpfPiZLg1/iDxIPp9dvepozP3NXVw8Pm26xS6GbECgYBqj3TwHYFrm7SG97VzmRtS2UiNhB5Rx3DBUHIusz/Z4t/rF5OEHvOFf4nj1CP1uoT0sxWtcfe5N4RXu/vi+H1JXah9L0abldG1u7qHMCYAXD7uqgM4boKvn1IS+LQJZC3Abe1I1gU4gKK/anu/94LaZklZgebYV5509PcpjiEwkQKBgE1gWWrQg7h1yAWC+Dw3BmUzErc6c9q9l5GAITDKy33FMBOr3w63aGb5jS6uUUKg0i7IzWYbAC2JhYpapqoHV54CkJuYSUR+nAxiIhCNn5KLRD9vcnNJX44YJyh6Za0jMTtA1fpZ0WzGHJLAD+mnS1Z9vngt1Tok4wQn1as75pSRAoGBAI5LfTxTQDl/TTCIsIzbEZw+3HI8P1tLC1sScqyiScJS0Lr8BsSjStALdGu0Or9kBvinI9xffR/E8b1S1/gQ7Pd0/D4l4Prhvi5lkPNQSbrdXIdw7YmHOHZk9K/HTjh3BTB39MGw3zgitMFBZpvZidaypR9iUFiLeFCZsAPJqDnt
a3a043f3-4c33-4423-8b2d-b09c9c94eb09	fc74b35e-856a-4b39-9362-3ba874a07ff6	certificate	MIICmzCCAYMCBgGGAprEnzANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjMwMTMwMTIxNDAyWhcNMzMwMTMwMTIxNTQyWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvf9tmCnMcybyXc9dyVUb4yQcX5U9bx60mA/UNAWS3htNMrdzAz9tE3dF0HtN6Lh0LGnsipazgoJELo0CUJScjX2TVx4UjDmcu40z694zy3QIKSvqwdQMTX7q8YNBPP98+t5zcf7Q2iBPbIEvqOutIbrWmRtFnFAyyylWys/sDqfak0XnaLb5RaNWz9BH/ONHVhBoNVW0qrMQL8oVZewspVIQK4a1qFRcceQUboDZZ+oETpi87J7+BA9dYHv4YJjQo2JEy1/DIu3eyd0Y56ZVyGxCT7u9MEcgovPN41ePcVcF5XKiPLoCnqnCIDE2AKNqNniL9flgI0cYu2CHQ/YiZAgMBAAEwDQYJKoZIhvcNAQELBQADggEBADbF0E8turVzDFNC/DnjAWf/owcZdAUSfMG/Y/RU3au+6OH97TkF5Icoa462bQcRr9FDotRuf346IV7YQg6ZLn32Xew7gwWNEvCS5BtAxRb7o9tzkh56HowM3dJQK+xU8TBtrxc4aBOpSN9sBKrh3fxM2Ub4uRmKYu2Fq14Ey2sN8keHprbuNXT29lGHjN6MNMEQpgaKwBACHWQvvYrNvtshdhSTG1iT7hm2ia4PTScpTkdMGC6sxVkk7nGCgHn/mj6saCothuARNgk+KGWPCYi4V7p7KgffuXXBvMPxMnCbevRVAX+bFPI3CKCGTkccqGmxE6fbW+mTr4cHSQwKe1U=
09ec622b-90f8-467e-814c-dae210222187	fc74b35e-856a-4b39-9362-3ba874a07ff6	priority	100
becb0b8b-f0f3-4045-9b25-647f995602a5	fc74b35e-856a-4b39-9362-3ba874a07ff6	keyUse	SIG
b106f54b-7c12-4a32-b646-d1af197a5dd6	11caf43d-e86e-4968-97a4-fee48f9b804c	priority	100
8ba91b6a-bbda-46bd-876d-bcc5f3d3d04e	11caf43d-e86e-4968-97a4-fee48f9b804c	certificate	MIICmzCCAYMCBgGGAprFSTANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjMwMTMwMTIxNDAyWhcNMzMwMTMwMTIxNTQyWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC5EA9VLoam6frBuTsIgDwRfLtAPMzeHfNbFJ/JKHgkTSg1Yqhipo1M3TxMnIldUZfTOaxCkPhdEFYL0wl0c/+swiol/uFdocCoIwqWAKS3R4mbuuQiRtpdXlBs8N9hG1tyT7RvciHGV8v2kyiWJNphYLa7miyWHWdZs7t3Ptflr/J+D0clyh7ET9pbcHXvLBcV8tbiaSW2B+bi7Yk/P9Oc7cIfhr3GzSw+t0//HIKVB37/QQk9j/hfSQWz+82ifZFoA+sSuurea4j1mFk3NeaU3bBWkeREyNm/fOmp52apRTA49oRHPWT8QFclnu4jhcyISOM/4SKqrCiy3+3mZazDAgMBAAEwDQYJKoZIhvcNAQELBQADggEBALdHZyorgHtli+L/LKxi1a0B13nnkyBU+dz15wv3fwTi7NMpfwO8Lj+7a22GwhMaLCjC9Dv39EEQmBQyVCsjqFmTNwoSW5HKDXAw2/RAm2GNfsvoRZvbr+HrQZuHiwM7rY1vLkmnCM3mfG48S5pqtg7IkKQlnwIbJnf99TyD1tdh5QtfY2BS1aLJgCi+eHx7jYqbSUNhuNr4ddqgzaXjDTauJVrX1tafjeZeQ4J2nQMfxaylX4NZvCcbTa1ieJfX7FrUx3g3JF+WK9e6iQvwXzIT4u/mfUg1JJf/38PNWiiEUI4v+lTBqLoF2yJncartpeX0PbGSavg1Xj3hI3jZpu0=
79df6edc-73b2-442e-a54d-fc506b868999	11caf43d-e86e-4968-97a4-fee48f9b804c	algorithm	RSA-OAEP
30d17b78-798a-41c1-8594-7b7d3f1f2b65	11caf43d-e86e-4968-97a4-fee48f9b804c	privateKey	MIIEpAIBAAKCAQEAuRAPVS6Gpun6wbk7CIA8EXy7QDzM3h3zWxSfySh4JE0oNWKoYqaNTN08TJyJXVGX0zmsQpD4XRBWC9MJdHP/rMIqJf7hXaHAqCMKlgCkt0eJm7rkIkbaXV5QbPDfYRtbck+0b3IhxlfL9pMoliTaYWC2u5oslh1nWbO7dz7X5a/yfg9HJcoexE/aW3B17ywXFfLW4mkltgfm4u2JPz/TnO3CH4a9xs0sPrdP/xyClQd+/0EJPY/4X0kFs/vNon2RaAPrErrq3muI9ZhZNzXmlN2wVpHkRMjZv3zpqedmqUUwOPaERz1k/EBXJZ7uI4XMiEjjP+Eiqqwost/t5mWswwIDAQABAoIBAE1DuUMVM77IfZsYHN+Fuo6KhxtgxyANXScvyy6PKOnvFNSFJkxZwTDQRXau/GLrx/m2YIdCQ4+HXIV/TLlEHQEh57sJWUpgWDFav/a0uhCTW46bTthIwK6uy+FQB9NhOqLVSD4nZpaK3WtLMWzOYia53FEjI25hRF8dPS2iHT2Vq1mld0UNlGp2f8Jk8ML6XUGUevelDSLE0uvHzbXk27aw1Wihg7vSEgyL5XYX7PtitJdOpgOlGjTbi9g2mHX93H0P9exQqy5J3+Ly7wh5HVolQUIxDsUyoCDgnzBqNUFbNVt+Jr6gHMabQrSBvUI5P5ZSvwdShFnhVjjzWggdEUECgYEA8lciIrz1st4sQDI6SseFFRo2KPNrK28hPRrCPh5MYTyhkISfrzXffZycQy7R7tRPjnfTZIuQ3p7X+TF1RBB8wFQJlDTkRHwnqsxu+2iDfIDBvcOKzAIOP4NF1owynwxTAcgCuKpVCKV5j18jGosNYOFp1ZSh1SZSifLiQ6pCmNECgYEAw35vY3IVlPi69k9D8tUQv15tUP1OgdQ3DZ+5vA8YJRStTvzx+zlblFZEH30HPbPPYtKCHuayrozywSPNBP1evzMJJmsb8gvq7Xpwb2Iz8OfxZuAGZLdBNG1rv6G5vdSqkEe3Kn6fnR0Mo5adMT/56O7o4iASMOcKX5zag7Y0UVMCgYEA0yKLAQz0W3QpxXx9QO13yxzdFuyM8HiP0vbfSNOI5Ca49Ho3zaT4JC4wDnBaQuQCtDM9n5nhC7QEon0ul7Btn/sXpWI3hltNDAe0oaE6/VwIb9ZPtNINq9QpInVfHSbVovWpOU5da30P3ZObt+JyM3fwhz5JiLUssDdGXoGWKCECgYBOuePxkEfQrjncZx9d8x/DcStkqh2reuKQwfnyGcIHbMQ+Qu7P1NFkczkL1TXNS1QA3/U2rIDYejpoPRqbH83AAbV1mzytxM7ew6fzswBny4AThbQNax7/FfGGQoKiR7pIUBkbK9LrWn90gXrcEn95pnxyU6f/uYsb5fa5g+6dsQKBgQCCSlSOZadXnyIjlDPbrx37PiOP0+GaynXkzIBngVxohezmnPizyfua3QKl682gKDs8ESIeBU9rmuhYK2lirG5ngh/KmZq2s18Z3M6RgtY8h5N9X9GF7ZdHzZJUimv4/HOpdCKQNsSMpeqEYUprGcNM9leozhq167B3PEsMijNOcw==
2c7f30d7-4100-4789-999e-6e2f4813858a	11caf43d-e86e-4968-97a4-fee48f9b804c	keyUse	ENC
c0152d2e-fc9c-49a2-ae2f-080f170ceaae	056f8219-7d76-4731-bd8d-8662b7e9f12d	secret	0RiE7qEuLzo0azv5laYFuQ
16db80b3-b1e9-4353-9367-4423dcb38b62	056f8219-7d76-4731-bd8d-8662b7e9f12d	priority	100
f31b0d5c-a55b-4512-8e79-03868bf23db1	056f8219-7d76-4731-bd8d-8662b7e9f12d	kid	fcdbe2dc-960a-4f46-8bfc-34f3e2c9cb6e
e3b5dffa-54a8-4eb6-b559-a58e99fb659e	0446adca-d69c-451c-a113-58f8eda6e19d	algorithm	HS256
b9194c7d-3979-4ef3-9eac-aa540f2c23b7	0446adca-d69c-451c-a113-58f8eda6e19d	kid	2d4ebf9d-7d29-4b15-873d-e6a050811ed6
992af350-db78-4723-bd74-77f4bdad64c4	0446adca-d69c-451c-a113-58f8eda6e19d	priority	100
bafc5b1f-74d4-4ae0-98d4-ee0e6cf0c01a	0446adca-d69c-451c-a113-58f8eda6e19d	secret	grSMKOGbu_RSeYVNUgokCiQ2-OAGzf1yBXzU__ARZhjkYndKapvebJUjJ3iQ7EyHmnJq6rHAhP-lyZB527Ij3g
ae0d70dc-b216-48b5-9004-bf625d3cac31	509a3de5-1808-4aa5-83c1-059ccac02d89	privateKey	MIIEowIBAAKCAQEAizfHBXNR4TWM8oo8TvX1+C+XQjoI0jXcM8RQZZxgs1nE04CuojVVlxN8c32+caqwkwfqRwGL/9Hlo2Aaj8jHq2RFSYR76Xd0tC4TH0tjjm6YM152FiOJmDW16XbdZERh3zRW8cbsy0t29AV9GtyMmWyTHZ3jOzyLaLROmmtRum8iffNI3EXsYnXpSnZNkhO8d0NPHS6Dsuj7IQ2bgh9i4Nkc3upD4jqhcHDE/9aHWCdhi82BzFSEOP2BUzH/5RCaDAxoDqDsyKTlKjyufP9Saslojq8Y0kGlDknuJ+V9B2I0J6ja3XeJCwFebtOi1YrAZyQHWZ6OYWFLzlhMvfjBPwIDAQABAoIBAC/45Wy8Yy+em1YMSmHPIZYHGDEq/FUrWBjCgg2xiCTlPwy+n+6nQDoR7eWCI/jZH4VayeDz6IEbm+zjNePsBNnLcJC3xVca4a0g31f+S20OMQYqe7h/QG+hunCblAh0A+G9EGS57mjTNUc7CPQToaNQpZUkDeQgpc1LrHZLmtsJ4H2myMMhRMN+C1fc+tCUjYDCVuEsETkl1R38pkz5ILjHNUZe7GBRfVxrjPs94fOTjszT3ucu42utiPkF9Wu+x+cIkYBZB16LsZK9CLiPhAKdFRvtvwEWctUP/iDR2oXJfeU+lhpXj/BrLcjtsktHiuGEmcFJufxPaXYhzPG16tECgYEA8nrhNyBk+W6k8ZnF4g+SZ3oHjhXpakQA3cclhjhgW4QgA3HABTeWCviBwVrt+eFadDJnbB9o32QeiysQ0G2TJIrFI+CW1enmET/RPM9SbyJ+xIQDSxZh2szKvw4qiwTgQANH8x4K7YGLXTb7zR+F7iByyMQilX1/4Ahdblyj8UcCgYEAkvrzb1AvzZ1NamN0HcXTR1k3FnNNXsAMguxnYfrpPGpiOEyMmTRDVDAqq7x0adpEjSANyruaWMt5U8kUEI6UQnYVnr5of5i2DWsKvjwZAPVeMs6AYFf/zcC7znmTdVRjGc2bjbfmpbeEgzHufizMg4wV7WiLBfXJb8qdB1qZbEkCgYEA5P9hlNNWKS7yPW1xMaZtKKZZXjmZYA9rFggOiyzQ63zjUv1pUEQHwsKgoD/EwZmu+E/l1nnvbBG8usfoMD9bmEYqGlDvgoRMD/xKGfjeLDDSsbrO9Wnk7mM8EqVJTlNDiZDPsW2s+lK+kEDuGvFrZdFlNe/tjWqhiq27tw9skN8CgYBow3jqubQpEdtRXqwwYIZVD9FFLlBSnf8M/uY9n3PJvWZfDKkWtnrbMi3oFT7BCHPeR5+tBoVgjz/eqa+kkYw5xyNn7/5aHIZ/D/IrYHjOBxbqjehRQ8gwZxU2ec/STKEKjlQ28oLzUdihDuEYjGQFy78BZofZarT2+utsh3ZeCQKBgD7TsTsX1nQjSHpcrWrlNonVEp1wiAkoKMh5CjG1ZENhQFbFcmVQAO4XKP96eQLnUgYDigIEdMy6SGsC6CybqgAfV4QOJ1Z1VsNxlJsJrbOXtagPbvGWBHAuJMwTFN0oyuLUllOqO9ORtJxPhCO00sllQOo864VlmaSp00eldHuu
7ece9dc7-7e7a-4df5-82b5-692e54e97a73	509a3de5-1808-4aa5-83c1-059ccac02d89	certificate	MIIClTCCAX0CBgGGDRNR1TANBgkqhkiG9w0BAQsFADAOMQwwCgYDVQQDDAN0eWswHhcNMjMwMjAxMTMwMTU1WhcNMzMwMjAxMTMwMzM1WjAOMQwwCgYDVQQDDAN0eWswggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCLN8cFc1HhNYzyijxO9fX4L5dCOgjSNdwzxFBlnGCzWcTTgK6iNVWXE3xzfb5xqrCTB+pHAYv/0eWjYBqPyMerZEVJhHvpd3S0LhMfS2OObpgzXnYWI4mYNbXpdt1kRGHfNFbxxuzLS3b0BX0a3IyZbJMdneM7PItotE6aa1G6byJ980jcRexidelKdk2SE7x3Q08dLoOy6PshDZuCH2Lg2Rze6kPiOqFwcMT/1odYJ2GLzYHMVIQ4/YFTMf/lEJoMDGgOoOzIpOUqPK58/1JqyWiOrxjSQaUOSe4n5X0HYjQnqNrdd4kLAV5u06LVisBnJAdZno5hYUvOWEy9+ME/AgMBAAEwDQYJKoZIhvcNAQELBQADggEBACXJ0O69ckqtjAIyUUhbE1VEHWMsgiS6vKEghc2HDKSM1gZpp3Qu38jwv496HGfST1szvJDn3yZ82dzgrOacexNx5ndS4RQuNDV1WS4uRaKNabORZp3ghSVfqGLX5jdp15V6FxZOzwR5l7wYJKg4sNQWK6hsQF1Kqnu7lhtmIyNGqMl6NvYkQf5RRCC5C8H2siMUJgkcyh/XN0vUUg3nmXu8nYewUeNJ8kBCHXCUPP86bflhxyB0jwGEDZffotSAeU9WVhUExd02tBZHrpKlAf1L/Y5l/TKXUJ2Zly8Iq4WBw+ZUguuBaGFBuAzoCK0mfhEnqvj3SbMINNGiGMG5adg=
addf1621-8365-466e-90cb-e4272c2f0acc	509a3de5-1808-4aa5-83c1-059ccac02d89	keyUse	SIG
bfb9e84c-9a7d-4c6b-89a9-5e69111f2150	509a3de5-1808-4aa5-83c1-059ccac02d89	priority	100
2f6621ab-0425-45bf-bced-bf0f23530442	980c33f7-2719-4d31-a9c5-7a2961edd87e	priority	100
4669801f-f589-43fd-b318-41538ba18215	980c33f7-2719-4d31-a9c5-7a2961edd87e	secret	dJt3CNT7NLtYoXqV-Cs2kA
3eb63514-d841-4552-8f06-caae4d426d41	980c33f7-2719-4d31-a9c5-7a2961edd87e	kid	468bbcab-9ca1-4de9-9309-6fccf2783864
22e881cc-faee-40bb-a5f0-015d3e84879e	2a043b43-ca0b-4add-878e-2b6a2997463c	certificate	MIIClTCCAX0CBgGGDRNSjTANBgkqhkiG9w0BAQsFADAOMQwwCgYDVQQDDAN0eWswHhcNMjMwMjAxMTMwMTU1WhcNMzMwMjAxMTMwMzM1WjAOMQwwCgYDVQQDDAN0eWswggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCEiJdGsLp4m5iQ2fKuF/EK5ANXy3UNVQRB03jE72yD8cBjuPUhcoDP0dQyQHvjHNTE847JkBxwP276WbscnzbDPOaLGDEk3JdiOnh6wms+vGBu77qxIeOixxF2YtENBXRSkggRrI4aEUcKQmOKVIYXntlBCnGG3P4qFuBYk0qXR1zBFwrOVInseJPOHvM2E27wY9GoKK5NZS9nViqQqwnlWv4+ABgsog+OGTdZoLpjBxOR+z44TD0h4oZa1QhQRSlbu35CIup9jGv9t2DNLDZg6lhUaNZuXmtJBXoaqV7ZZnFqvYr+gQOwCNdZH/KafHUb73TskKygfKYaWX2dO9gXAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAFeSQBG7FmbyCcsocXUHHH4sfYthU5TeNukNTAbfoAF8acqR5WSBr3W+Sxea2+8dAl1ApZzN6iuz05UI2hZkpk4R8E96pJY9441gyxiL7Hk9EnZ1AzW1vNwnzYKU8s33/CyPtm5A/5RrW/1K1+4OTxTsZ/jYLByeoEXLp4Lh9aIsUI/KGbxhgeTEio+e++gBxSp2nXeQ67AdZZLXRrAMS8soA3jZUMw/tIq5B8SKsP4rF/P0I7FVElH711eUg8QiSEGlRPtT/dWqi7Ahj3ED3eJK/Cp7qMJ1Ib7oDWNjDitBxxKXo5DvxHPz2kyfpbbwaAS2eDoqJQq4mX+FUzOR3Wk=
1fb1a79e-0d14-4eea-91ac-dbb0f41996b4	2a043b43-ca0b-4add-878e-2b6a2997463c	priority	100
f20d2770-cf01-4b9c-9767-8fb452f524f7	2a043b43-ca0b-4add-878e-2b6a2997463c	algorithm	RSA-OAEP
087a8b48-b06c-46cd-a417-35c16aac0c29	2a043b43-ca0b-4add-878e-2b6a2997463c	privateKey	MIIEowIBAAKCAQEAhIiXRrC6eJuYkNnyrhfxCuQDV8t1DVUEQdN4xO9sg/HAY7j1IXKAz9HUMkB74xzUxPOOyZAccD9u+lm7HJ82wzzmixgxJNyXYjp4esJrPrxgbu+6sSHjoscRdmLRDQV0UpIIEayOGhFHCkJjilSGF57ZQQpxhtz+KhbgWJNKl0dcwRcKzlSJ7HiTzh7zNhNu8GPRqCiuTWUvZ1YqkKsJ5Vr+PgAYLKIPjhk3WaC6YwcTkfs+OEw9IeKGWtUIUEUpW7t+QiLqfYxr/bdgzSw2YOpYVGjWbl5rSQV6Gqle2WZxar2K/oEDsAjXWR/ymnx1G+907JCsoHymGll9nTvYFwIDAQABAoIBAGgqy2ueQBHHidRf2SQIYUYEDLSWjzuZVK1APy3aWNojyukWWGSfkKrG6xdMI5NP99OM8u9tu0xmLx3KJQzL/sjZNwKgUw/76WglOMiTwqMegFTxSzUpw7cO66S26kRnwxOa/4iUrWPDrKhdocr5wCMUkQFT6gLr80C1lkNIEVpwZ2YMVxSlj+uNPMek5jHn8eWvlEwRbLywZmcwuEQvBqmFtV2XSCgXUuuzm//vLDOu/bXS1E+T7N9Y6ov0L8vZEAALy7Qd69a/s62R+DaBq9tQnxWRJMXzGud75+RMvyF2ssP0ETbp6IUFwPddiZ6rPqc5PWo6bfJGEZYl5MbabRECgYEA+ajxPf05JFE8DxHyxBzwAEQ7zwJhpfAB9SbJyaFgkAMJUWjI60jEFQS0Nq4iOf8iUVFIute8ktU2VWXUCUFcoZFLhLx2L6ZVuqfHeoWxExzijH6X14XjDU/dXbx2pZ1KEfgUoCb6wr2YKbjNHDckt/XrOMS6efZPVkhYTKBHkC0CgYEAh+YzjRkCKrUan0AGn0jwNBbLErjVXzBD3zcjw8gfImGRFjVXHP1QzGQWeDfl70EynEdQhpsJNQNlt+zt2n1OPEM1CvJ1PG7EsNotne9TSYd1tXCbqDAPI1rwyfS2r/rTs6KJKezPWA/63JOO8EpKQ4rd0H16nI9hEbIFWf7+79MCgYEA1XZoxkrT58R5aJ09CAeCAYhV5vqvSTU8R0Mh938+1AN0nSHN4La3yQzblYEwDIyj6Alq+S5qstUQftXxBPTY4eAcROLq3nUHCfBYs97Jd4EUB3JaG9IDP6eQq4vvmk0xPsnxwLlzYLzA9LNo1H4lrBDdTQ2QL6W1Uh3LOcE1TwUCgYAQWCVXEOzrygA7qu2g9pq9CQi/Za9z1VA0ZmNMxqLH9cgHTb7+Y5D2JAt3xfFHhyXZGdKbfcXrtE7lgf9RScTBBqw4dtSWwhOx2WunFQOFUl9bxQFThwQrEmLnRyE5pQcVEbVBb5O4WaOoJ68HQ0gPO4JV8uFuNuhLwodWPY7XtQKBgCsbYG1ZCWV5/HVcy8RbhxU+7W5cW0bulZChd27HMR+6uN1PXoUwBUu5QKs2BCPzIh7aITQPTUNV/t/e79W5vXqYQM6PmhixjJyEdn6iXQ0FGDIteF2n8oKcCVOpQTRJzt+kOF7STLXAgxLZJdTtjNbzX+bxtU0c2/i/FxbIOmtj
3534e27c-1f43-441a-a750-af6cba1a7619	2a043b43-ca0b-4add-878e-2b6a2997463c	keyUse	ENC
da24f700-b095-48b8-8fa3-051b708977af	70d2a049-52f1-4305-8753-9ee0c6c73672	secret	jy5X1L480hsRwaWNUaQ5q8X2pWa4pNbD1oPQzuETe1sVOwQ0djPW4NFYMjuuTznZq79eIgg51L5XWMot2_qxVw
a379236f-cefb-4478-8462-3a6c19c551fd	70d2a049-52f1-4305-8753-9ee0c6c73672	priority	100
d0b88db8-2f15-466f-ba8c-ffd41ded6a63	70d2a049-52f1-4305-8753-9ee0c6c73672	kid	82c51ae2-f093-4d7f-98cf-b3adaecc7792
67e8eccc-d0de-4628-8276-0c4e0347da5b	70d2a049-52f1-4305-8753-9ee0c6c73672	algorithm	HS256
c73b83a0-b0e9-4fd2-9b38-c0ded341e64d	712f9c9f-5835-4d2b-a39e-f6f0973485d4	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
e73589fc-7b96-425b-a55a-18593b61e27a	712f9c9f-5835-4d2b-a39e-f6f0973485d4	allowed-protocol-mapper-types	oidc-address-mapper
167ddd25-78f8-410e-b828-f00bf3eee6d7	712f9c9f-5835-4d2b-a39e-f6f0973485d4	allowed-protocol-mapper-types	oidc-full-name-mapper
973b79ac-5a17-4438-ab4c-0cd18420dbe8	712f9c9f-5835-4d2b-a39e-f6f0973485d4	allowed-protocol-mapper-types	saml-role-list-mapper
34e21ab7-0426-429a-bf32-6d3a134099c0	712f9c9f-5835-4d2b-a39e-f6f0973485d4	allowed-protocol-mapper-types	saml-user-property-mapper
09b98644-fb83-421d-a938-07584b87691b	712f9c9f-5835-4d2b-a39e-f6f0973485d4	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
6c678bba-b729-4ff5-a7ab-d122cbbb1101	712f9c9f-5835-4d2b-a39e-f6f0973485d4	allowed-protocol-mapper-types	saml-user-attribute-mapper
970f27c1-3fe0-4651-a7be-cd6f7f728f48	712f9c9f-5835-4d2b-a39e-f6f0973485d4	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
d396058a-4ed0-4b3a-be98-cbef462cb4c9	d403fc8c-c3a1-4d2d-8292-6422e32101e9	client-uris-must-match	true
16d065bb-d1c5-432d-9f93-88e10e6e6cee	d403fc8c-c3a1-4d2d-8292-6422e32101e9	host-sending-registration-request-must-match	true
3a244e4e-28e1-4483-a773-8d3434d7d89b	e6eddfaa-1057-4074-b8f5-7084dd09c5e7	allowed-protocol-mapper-types	saml-user-attribute-mapper
ab7f96c2-3d3c-4704-853f-ea8eaaaba180	e6eddfaa-1057-4074-b8f5-7084dd09c5e7	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
dec4a338-7ec7-4cd7-b56e-e652037067c7	e6eddfaa-1057-4074-b8f5-7084dd09c5e7	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
24543896-7778-4092-ad85-d27417afb188	e6eddfaa-1057-4074-b8f5-7084dd09c5e7	allowed-protocol-mapper-types	oidc-full-name-mapper
c0f16f79-d675-4864-b9de-0fd1d9416ba4	e6eddfaa-1057-4074-b8f5-7084dd09c5e7	allowed-protocol-mapper-types	saml-role-list-mapper
f037f3e5-a720-40e8-a47f-d90a9c023bb6	e6eddfaa-1057-4074-b8f5-7084dd09c5e7	allowed-protocol-mapper-types	oidc-address-mapper
b22354ce-e836-44b6-9dce-3789574e5616	e6eddfaa-1057-4074-b8f5-7084dd09c5e7	allowed-protocol-mapper-types	saml-user-property-mapper
42e12644-c05a-4c7b-8dd2-6347ca333cd9	e6eddfaa-1057-4074-b8f5-7084dd09c5e7	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
d0a57e79-0e9e-4de0-888f-c7bd89e7d524	325902d1-d525-4c31-ac44-61105ade18ab	allow-default-scopes	true
88105c1d-d0b8-4dc1-a0d4-a866b43389f0	8a86a6fc-99ee-4938-ad2e-1d24ed9cc9ab	max-clients	200
44b6499e-23c5-4cf3-b181-81f79c778250	a0dde884-ae4b-4c25-b86f-302bb453bded	allow-default-scopes	true
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.composite_role (composite, child_role) FROM stdin;
39071732-3c50-42e6-8875-b59365b79e9e	fa4f4d9d-88db-4cc6-bcba-bb2629cae768
39071732-3c50-42e6-8875-b59365b79e9e	4b329d6f-bcda-460d-81bc-e96ded2cc59c
39071732-3c50-42e6-8875-b59365b79e9e	4f11637e-e93e-4500-904e-28627834380a
39071732-3c50-42e6-8875-b59365b79e9e	799058c6-e174-4491-91e8-10587ede54d5
39071732-3c50-42e6-8875-b59365b79e9e	7db97161-6c77-4f75-bf1f-a0fd85ae3336
39071732-3c50-42e6-8875-b59365b79e9e	d5e13cf0-50dc-46d6-9cd1-f8e7f6eeafef
39071732-3c50-42e6-8875-b59365b79e9e	922366db-abaa-4e43-8e50-1747e038d954
39071732-3c50-42e6-8875-b59365b79e9e	9d9edb85-af98-4cbb-8aad-92442ffb2cf6
39071732-3c50-42e6-8875-b59365b79e9e	f642b76c-837c-441d-9537-bec56d709e7f
39071732-3c50-42e6-8875-b59365b79e9e	221c68a6-7025-492d-b00d-d17641f2a053
39071732-3c50-42e6-8875-b59365b79e9e	0c502dd4-5610-47e9-aa3c-30d98fa14c74
39071732-3c50-42e6-8875-b59365b79e9e	eed83f13-8b78-49dd-84f0-ab63d731f02f
39071732-3c50-42e6-8875-b59365b79e9e	e8857779-7344-42d4-a4f9-1fa14a0552b4
39071732-3c50-42e6-8875-b59365b79e9e	e81cc60c-a3fd-4c0f-9ce0-d60bacaf9bfc
39071732-3c50-42e6-8875-b59365b79e9e	80a4236c-6710-485e-8974-4dc0cbb19e0f
39071732-3c50-42e6-8875-b59365b79e9e	f2ce803d-5089-405e-af73-cf932c5ae69a
39071732-3c50-42e6-8875-b59365b79e9e	5b16aff4-4052-4c4d-b1a9-206bbbcdfc8a
39071732-3c50-42e6-8875-b59365b79e9e	497a139e-c556-4901-82c4-296a1aa34ea1
7db97161-6c77-4f75-bf1f-a0fd85ae3336	f2ce803d-5089-405e-af73-cf932c5ae69a
799058c6-e174-4491-91e8-10587ede54d5	80a4236c-6710-485e-8974-4dc0cbb19e0f
799058c6-e174-4491-91e8-10587ede54d5	497a139e-c556-4901-82c4-296a1aa34ea1
bfcc3128-ef87-4b8b-ba09-98c8523acf90	51e5a345-f8f9-47ef-9915-4e7c37826354
bfcc3128-ef87-4b8b-ba09-98c8523acf90	d11a5602-5aca-4fd1-9e7d-232e48e3ffb9
d11a5602-5aca-4fd1-9e7d-232e48e3ffb9	bb8e600a-baf2-45ea-ac7c-bd899be48c9e
7e67116b-5261-4162-aaf1-58abfa86c32a	1e44a5f9-e3b1-4ed6-94c1-7ef41f4c25ea
39071732-3c50-42e6-8875-b59365b79e9e	0ce5fb51-56c4-41cf-9ce3-0007d15a532a
bfcc3128-ef87-4b8b-ba09-98c8523acf90	0e32413c-2b78-4863-9739-ab50d688a817
bfcc3128-ef87-4b8b-ba09-98c8523acf90	9338cb29-d046-40c9-bf3d-15094d377725
39071732-3c50-42e6-8875-b59365b79e9e	9280f142-11f9-41b1-8160-c293fd933b58
39071732-3c50-42e6-8875-b59365b79e9e	40f1caa4-dd7c-40c3-ad55-d36c4aa8be14
39071732-3c50-42e6-8875-b59365b79e9e	05571967-5196-423b-9cb3-03980048466d
39071732-3c50-42e6-8875-b59365b79e9e	2ca9daef-ef35-454d-99c6-fd24bfb5d78a
39071732-3c50-42e6-8875-b59365b79e9e	ecd7d993-c6a8-48d6-8ad8-e56424a60e1b
39071732-3c50-42e6-8875-b59365b79e9e	a662900c-6c29-4b77-9c1c-ff9bbfa874fa
39071732-3c50-42e6-8875-b59365b79e9e	9d42fdee-0619-4ea7-b3a7-999c381e4648
39071732-3c50-42e6-8875-b59365b79e9e	965c508a-c84a-41c2-ab84-7d371f2babf1
39071732-3c50-42e6-8875-b59365b79e9e	606acaf9-10f5-4553-9ef0-850d313348dc
39071732-3c50-42e6-8875-b59365b79e9e	eff250a5-63f8-4897-8b2e-b12d38be0fa6
39071732-3c50-42e6-8875-b59365b79e9e	f59c59b1-467f-4178-92dc-ed341bfbac63
39071732-3c50-42e6-8875-b59365b79e9e	334bf5ed-024e-41b6-b9d8-05339d79bef1
39071732-3c50-42e6-8875-b59365b79e9e	9b5f45de-3171-4694-82fe-dfef92f88b80
39071732-3c50-42e6-8875-b59365b79e9e	ff9eb526-c558-4d04-8307-85633abf2b02
39071732-3c50-42e6-8875-b59365b79e9e	57d3ccac-6e9a-42e4-9e11-107beb9f0eb1
39071732-3c50-42e6-8875-b59365b79e9e	7a7c0d72-e83f-4301-a652-15fc3c862447
39071732-3c50-42e6-8875-b59365b79e9e	07033fb5-9a86-49e6-b76a-0c1aa7705982
2ca9daef-ef35-454d-99c6-fd24bfb5d78a	57d3ccac-6e9a-42e4-9e11-107beb9f0eb1
05571967-5196-423b-9cb3-03980048466d	ff9eb526-c558-4d04-8307-85633abf2b02
05571967-5196-423b-9cb3-03980048466d	07033fb5-9a86-49e6-b76a-0c1aa7705982
0133c64c-8134-479b-a37a-595a67ca6045	05e62aef-9d98-4d32-95c3-eccb7a46b06e
0133c64c-8134-479b-a37a-595a67ca6045	38eec677-8bf0-400e-ac07-7f4bc3ba45f5
0133c64c-8134-479b-a37a-595a67ca6045	1583729f-2be7-4a86-86da-473a8907e4f2
0133c64c-8134-479b-a37a-595a67ca6045	ed6eaf11-709e-4349-8c96-7f9f357ee7bb
0133c64c-8134-479b-a37a-595a67ca6045	14d8252f-8a34-41d4-8dee-458a498527cc
0133c64c-8134-479b-a37a-595a67ca6045	3f159ed2-0795-4c74-99ac-2728167f3357
0133c64c-8134-479b-a37a-595a67ca6045	4cc00c83-ecec-4baa-8b37-057468cb6711
0133c64c-8134-479b-a37a-595a67ca6045	7bbef091-935f-41fc-b27d-6a785c43aa46
0133c64c-8134-479b-a37a-595a67ca6045	f85ddac8-8e6b-4156-99db-10b8f3e5e911
0133c64c-8134-479b-a37a-595a67ca6045	da236cb5-7a2d-4436-b40f-229360b2276d
0133c64c-8134-479b-a37a-595a67ca6045	29c21d96-027a-49f4-b503-f54251e9dd5c
0133c64c-8134-479b-a37a-595a67ca6045	fcad3a30-6dd9-47c3-9802-a7f9d85ebaa4
0133c64c-8134-479b-a37a-595a67ca6045	8fa765d5-05b9-43db-8cc3-2887d5631ee3
0133c64c-8134-479b-a37a-595a67ca6045	0c2fd3bb-d85f-4d88-a27a-65443a9a9b5a
0133c64c-8134-479b-a37a-595a67ca6045	49387c80-bf6c-46a9-8ca6-4f42398a5231
0133c64c-8134-479b-a37a-595a67ca6045	797a3b7c-40f3-4aab-82da-f30a29b7f9fd
0133c64c-8134-479b-a37a-595a67ca6045	d5ddff1e-56e9-4a34-90fd-2b3cdebbc771
ed6eaf11-709e-4349-8c96-7f9f357ee7bb	49387c80-bf6c-46a9-8ca6-4f42398a5231
1583729f-2be7-4a86-86da-473a8907e4f2	d5ddff1e-56e9-4a34-90fd-2b3cdebbc771
1583729f-2be7-4a86-86da-473a8907e4f2	0c2fd3bb-d85f-4d88-a27a-65443a9a9b5a
0183e391-1caf-4a42-adf6-ffc53d6b2c75	274b4dc8-a0f6-4ed3-a3df-4e8dfb75bce7
0183e391-1caf-4a42-adf6-ffc53d6b2c75	1095c55e-6274-4a41-a5cb-1303c103fa98
1095c55e-6274-4a41-a5cb-1303c103fa98	e403fd20-2d2d-4c30-98f5-886c4fe18410
d41ac1ed-ea99-4914-ac57-4607d9fd8637	442514a3-4526-4243-8a10-df8fec1626ef
39071732-3c50-42e6-8875-b59365b79e9e	31af4089-7502-4d98-b2d0-ad1165a49169
0133c64c-8134-479b-a37a-595a67ca6045	6699f02c-f3ba-4ad6-a5f2-b9241e94a3db
b9e0c4ab-5749-44c4-88a4-1af8f7915634	9eddc240-6298-4c2a-858d-b92350a4d549
82e625af-47f0-4348-b7f8-f0383b043c2c	9406fdf8-2fb4-4c37-a97e-86f2ffa6674b
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
e27d22c1-8589-4d61-a424-10fb24d1d185	\N	password	752d82f3-0255-453f-83ae-7c02a7d8d17a	1675080943347	\N	{"value":"dYB4ghv3wcJXm1DuUm8kVFh2A6uNzt5pfxR99Cttt40T7gava6JvDKpBFci2NkwHVtZt36TE2zXEmXOnJMkzaQ==","salt":"yOfF3cTbm2bNlgbTZrvjSg==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
e6ce77cd-bc12-46bb-87dd-24e2bf996685	\N	password	ac84870e-daf1-4e94-9624-af912c579518	1675340352269	\N	{"value":"q34PYxD1uqCYwciBWhno7q0yMY+C6IjgIsAWce/QrHzJ2IRZkCB2wVx21n3ge4yqy9fnHqb4EY9g9fq25jWIhA==","salt":"FhbPtNraRCQJbnw25V3HWg==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
25fbe046-5e0a-4bda-bd1d-4a84b13962f7	\N	password	68557f5d-ecfc-4816-b711-52f7303497ea	1675358758912	\N	{"value":"Il9cs8uAgmvyWNOQR/28qMiQREHcY0+lgGseNnKCAxNK5UpRylFfYO6WdjDqRApBaJDCYp/HwifuYuq1XHs2xQ==","salt":"L9zzIVongAVwn5M4EvUp+A==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
9d576398-4627-485f-97fe-58e46f31819e	\N	password	c616335e-e575-46ec-96f1-93cb793ee70b	1679566661499	\N	{"value":"/hdZXvfirOu6HUfWskwpZtN3mZ92cyyjofb1RjJnJV0hpvT+HSlUSmDCLhAbCKtx8nULkOPxmeuBt/Qw/80uqw==","salt":"ezcIFiRKKPX5ssIyTHDeJw==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
4ace14b0-64ab-4033-abbd-5ce03cdcf9fd	\N	password	63b0bdc6-6e4c-457a-847c-6e6544ae57d0	1682774205972	\N	{"value":"92XvFfZbzQ1ttOqWqhNl15wnajVYCa6Sm+piOWjHyUZoCnP1YgQSGYAyxQvKzrc/3zFgoGEX07qNT38NhMXy2g==","salt":"/ZKfQanNRBVFTgYUFpohoQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2023-01-30 12:15:36.637903	1	EXECUTED	7:4e70412f24a3f382c82183742ec79317	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	5080936299
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2023-01-30 12:15:36.648461	2	MARK_RAN	7:cb16724583e9675711801c6875114f28	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	5080936299
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2023-01-30 12:15:36.681895	3	EXECUTED	7:0310eb8ba07cec616460794d42ade0fa	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	3.5.4	\N	\N	5080936299
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2023-01-30 12:15:36.686674	4	EXECUTED	7:5d25857e708c3233ef4439df1f93f012	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	3.5.4	\N	\N	5080936299
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2023-01-30 12:15:36.768371	5	EXECUTED	7:c7a54a1041d58eb3817a4a883b4d4e84	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	5080936299
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2023-01-30 12:15:36.772861	6	MARK_RAN	7:2e01012df20974c1c2a605ef8afe25b7	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	5080936299
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2023-01-30 12:15:36.844087	7	EXECUTED	7:0f08df48468428e0f30ee59a8ec01a41	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	5080936299
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2023-01-30 12:15:36.849228	8	MARK_RAN	7:a77ea2ad226b345e7d689d366f185c8c	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	5080936299
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2023-01-30 12:15:36.854717	9	EXECUTED	7:a3377a2059aefbf3b90ebb4c4cc8e2ab	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	3.5.4	\N	\N	5080936299
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2023-01-30 12:15:36.93689	10	EXECUTED	7:04c1dbedc2aa3e9756d1a1668e003451	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	3.5.4	\N	\N	5080936299
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2023-01-30 12:15:36.985479	11	EXECUTED	7:36ef39ed560ad07062d956db861042ba	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	5080936299
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2023-01-30 12:15:36.988122	12	MARK_RAN	7:d909180b2530479a716d3f9c9eaea3d7	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	5080936299
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2023-01-30 12:15:37.00238	13	EXECUTED	7:cf12b04b79bea5152f165eb41f3955f6	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	5080936299
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-01-30 12:15:37.022201	14	EXECUTED	7:7e32c8f05c755e8675764e7d5f514509	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	3.5.4	\N	\N	5080936299
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-01-30 12:15:37.024914	15	MARK_RAN	7:980ba23cc0ec39cab731ce903dd01291	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	5080936299
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-01-30 12:15:37.027524	16	MARK_RAN	7:2fa220758991285312eb84f3b4ff5336	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	3.5.4	\N	\N	5080936299
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-01-30 12:15:37.029581	17	EXECUTED	7:d41d8cd98f00b204e9800998ecf8427e	empty		\N	3.5.4	\N	\N	5080936299
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2023-01-30 12:15:37.067548	18	EXECUTED	7:91ace540896df890cc00a0490ee52bbc	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	3.5.4	\N	\N	5080936299
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2023-01-30 12:15:37.107336	19	EXECUTED	7:c31d1646dfa2618a9335c00e07f89f24	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	5080936299
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2023-01-30 12:15:37.112159	20	EXECUTED	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	5080936299
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-01-30 12:15:38.175099	45	EXECUTED	7:6a48ce645a3525488a90fbf76adf3bb3	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	5080936299
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2023-01-30 12:15:37.114871	21	MARK_RAN	7:f987971fe6b37d963bc95fee2b27f8df	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	5080936299
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2023-01-30 12:15:37.117706	22	MARK_RAN	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	5080936299
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2023-01-30 12:15:37.156044	23	EXECUTED	7:ed2dc7f799d19ac452cbcda56c929e47	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	3.5.4	\N	\N	5080936299
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2023-01-30 12:15:37.160659	24	EXECUTED	7:80b5db88a5dda36ece5f235be8757615	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	5080936299
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2023-01-30 12:15:37.162648	25	MARK_RAN	7:1437310ed1305a9b93f8848f301726ce	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	5080936299
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2023-01-30 12:15:37.333215	26	EXECUTED	7:b82ffb34850fa0836be16deefc6a87c4	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	3.5.4	\N	\N	5080936299
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2023-01-30 12:15:37.404656	27	EXECUTED	7:9cc98082921330d8d9266decdd4bd658	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	3.5.4	\N	\N	5080936299
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2023-01-30 12:15:37.408102	28	EXECUTED	7:03d64aeed9cb52b969bd30a7ac0db57e	update tableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	5080936299
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2023-01-30 12:15:37.470565	29	EXECUTED	7:f1f9fd8710399d725b780f463c6b21cd	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	3.5.4	\N	\N	5080936299
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2023-01-30 12:15:37.48294	30	EXECUTED	7:53188c3eb1107546e6f765835705b6c1	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	3.5.4	\N	\N	5080936299
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2023-01-30 12:15:37.497322	31	EXECUTED	7:d6e6f3bc57a0c5586737d1351725d4d4	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	3.5.4	\N	\N	5080936299
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2023-01-30 12:15:37.501536	32	EXECUTED	7:454d604fbd755d9df3fd9c6329043aa5	customChange		\N	3.5.4	\N	\N	5080936299
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-01-30 12:15:37.506157	33	EXECUTED	7:57e98a3077e29caf562f7dbf80c72600	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	5080936299
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-01-30 12:15:37.508182	34	MARK_RAN	7:e4c7e8f2256210aee71ddc42f538b57a	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	5080936299
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-01-30 12:15:37.533774	35	EXECUTED	7:09a43c97e49bc626460480aa1379b522	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	5080936299
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2023-01-30 12:15:37.538768	36	EXECUTED	7:26bfc7c74fefa9126f2ce702fb775553	addColumn tableName=REALM		\N	3.5.4	\N	\N	5080936299
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-01-30 12:15:37.546436	37	EXECUTED	7:a161e2ae671a9020fff61e996a207377	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	5080936299
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2023-01-30 12:15:37.549846	38	EXECUTED	7:37fc1781855ac5388c494f1442b3f717	addColumn tableName=FED_USER_CONSENT		\N	3.5.4	\N	\N	5080936299
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2023-01-30 12:15:37.552974	39	EXECUTED	7:13a27db0dae6049541136adad7261d27	addColumn tableName=IDENTITY_PROVIDER		\N	3.5.4	\N	\N	5080936299
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-01-30 12:15:37.55504	40	MARK_RAN	7:550300617e3b59e8af3a6294df8248a3	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	5080936299
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-01-30 12:15:37.557332	41	MARK_RAN	7:e3a9482b8931481dc2772a5c07c44f17	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	5080936299
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2023-01-30 12:15:37.561425	42	EXECUTED	7:72b07d85a2677cb257edb02b408f332d	customChange		\N	3.5.4	\N	\N	5080936299
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-01-30 12:15:38.166901	43	EXECUTED	7:a72a7858967bd414835d19e04d880312	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	3.5.4	\N	\N	5080936299
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2023-01-30 12:15:38.171496	44	EXECUTED	7:94edff7cf9ce179e7e85f0cd78a3cf2c	addColumn tableName=USER_ENTITY		\N	3.5.4	\N	\N	5080936299
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-01-30 12:15:38.178625	46	EXECUTED	7:e64b5dcea7db06077c6e57d3b9e5ca14	customChange		\N	3.5.4	\N	\N	5080936299
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-01-30 12:15:38.180581	47	MARK_RAN	7:fd8cf02498f8b1e72496a20afc75178c	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	5080936299
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-01-30 12:15:38.242625	48	EXECUTED	7:542794f25aa2b1fbabb7e577d6646319	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	3.5.4	\N	\N	5080936299
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-01-30 12:15:38.246833	49	EXECUTED	7:edad604c882df12f74941dac3cc6d650	addColumn tableName=REALM		\N	3.5.4	\N	\N	5080936299
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2023-01-30 12:15:38.287822	50	EXECUTED	7:0f88b78b7b46480eb92690cbf5e44900	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	3.5.4	\N	\N	5080936299
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2023-01-30 12:15:38.446267	51	EXECUTED	7:d560e43982611d936457c327f872dd59	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	3.5.4	\N	\N	5080936299
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2023-01-30 12:15:38.449939	52	EXECUTED	7:c155566c42b4d14ef07059ec3b3bbd8e	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	5080936299
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2023-01-30 12:15:38.452535	53	EXECUTED	7:b40376581f12d70f3c89ba8ddf5b7dea	update tableName=REALM		\N	3.5.4	\N	\N	5080936299
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2023-01-30 12:15:38.45511	54	EXECUTED	7:a1132cc395f7b95b3646146c2e38f168	update tableName=CLIENT		\N	3.5.4	\N	\N	5080936299
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-01-30 12:15:38.46147	55	EXECUTED	7:d8dc5d89c789105cfa7ca0e82cba60af	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	3.5.4	\N	\N	5080936299
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-01-30 12:15:38.475594	56	EXECUTED	7:7822e0165097182e8f653c35517656a3	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	3.5.4	\N	\N	5080936299
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-01-30 12:15:38.507732	57	EXECUTED	7:c6538c29b9c9a08f9e9ea2de5c2b6375	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	3.5.4	\N	\N	5080936299
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-01-30 12:15:38.744282	58	EXECUTED	7:6d4893e36de22369cf73bcb051ded875	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	3.5.4	\N	\N	5080936299
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2023-01-30 12:15:38.770375	59	EXECUTED	7:57960fc0b0f0dd0563ea6f8b2e4a1707	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	3.5.4	\N	\N	5080936299
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2023-01-30 12:15:38.786432	60	EXECUTED	7:2b4b8bff39944c7097977cc18dbceb3b	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	5080936299
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2023-01-30 12:15:38.79364	61	EXECUTED	7:2aa42a964c59cd5b8ca9822340ba33a8	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	3.5.4	\N	\N	5080936299
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2023-01-30 12:15:38.799316	62	EXECUTED	7:9ac9e58545479929ba23f4a3087a0346	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	3.5.4	\N	\N	5080936299
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2023-01-30 12:15:38.802564	63	EXECUTED	7:14d407c35bc4fe1976867756bcea0c36	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	5080936299
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2023-01-30 12:15:38.805117	64	EXECUTED	7:241a8030c748c8548e346adee548fa93	update tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	5080936299
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2023-01-30 12:15:38.807827	65	EXECUTED	7:7d3182f65a34fcc61e8d23def037dc3f	update tableName=RESOURCE_SERVER_RESOURCE		\N	3.5.4	\N	\N	5080936299
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2023-01-30 12:15:38.832724	66	EXECUTED	7:b30039e00a0b9715d430d1b0636728fa	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	3.5.4	\N	\N	5080936299
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2023-01-30 12:15:38.848544	67	EXECUTED	7:3797315ca61d531780f8e6f82f258159	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	3.5.4	\N	\N	5080936299
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2023-01-30 12:15:38.852759	68	EXECUTED	7:c7aa4c8d9573500c2d347c1941ff0301	addColumn tableName=REALM		\N	3.5.4	\N	\N	5080936299
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2023-01-30 12:15:38.871236	69	EXECUTED	7:b207faee394fc074a442ecd42185a5dd	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	3.5.4	\N	\N	5080936299
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2023-01-30 12:15:38.875715	70	EXECUTED	7:ab9a9762faaba4ddfa35514b212c4922	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	3.5.4	\N	\N	5080936299
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2023-01-30 12:15:38.879511	71	EXECUTED	7:b9710f74515a6ccb51b72dc0d19df8c4	addColumn tableName=RESOURCE_SERVER		\N	3.5.4	\N	\N	5080936299
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-01-30 12:15:38.884764	72	EXECUTED	7:ec9707ae4d4f0b7452fee20128083879	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	5080936299
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-01-30 12:15:38.88955	73	EXECUTED	7:3979a0ae07ac465e920ca696532fc736	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	5080936299
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-01-30 12:15:38.891714	74	MARK_RAN	7:5abfde4c259119d143bd2fbf49ac2bca	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	5080936299
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-01-30 12:15:38.902667	75	EXECUTED	7:b48da8c11a3d83ddd6b7d0c8c2219345	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	3.5.4	\N	\N	5080936299
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-01-30 12:15:38.919825	76	EXECUTED	7:a73379915c23bfad3e8f5c6d5c0aa4bd	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	3.5.4	\N	\N	5080936299
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-01-30 12:15:38.92303	77	EXECUTED	7:39e0073779aba192646291aa2332493d	addColumn tableName=CLIENT		\N	3.5.4	\N	\N	5080936299
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-01-30 12:15:38.925018	78	MARK_RAN	7:81f87368f00450799b4bf42ea0b3ec34	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	3.5.4	\N	\N	5080936299
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-01-30 12:15:38.943769	79	EXECUTED	7:20b37422abb9fb6571c618148f013a15	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	3.5.4	\N	\N	5080936299
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-01-30 12:15:38.946033	80	MARK_RAN	7:1970bb6cfb5ee800736b95ad3fb3c78a	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	3.5.4	\N	\N	5080936299
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-01-30 12:15:38.961292	81	EXECUTED	7:45d9b25fc3b455d522d8dcc10a0f4c80	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	3.5.4	\N	\N	5080936299
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-01-30 12:15:38.963305	82	MARK_RAN	7:890ae73712bc187a66c2813a724d037f	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	5080936299
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-01-30 12:15:38.967188	83	EXECUTED	7:0a211980d27fafe3ff50d19a3a29b538	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	5080936299
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-01-30 12:15:38.969043	84	MARK_RAN	7:a161e2ae671a9020fff61e996a207377	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	5080936299
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-01-30 12:15:38.983846	85	EXECUTED	7:01c49302201bdf815b0a18d1f98a55dc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	3.5.4	\N	\N	5080936299
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2023-01-30 12:15:38.988122	86	EXECUTED	7:3dace6b144c11f53f1ad2c0361279b86	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	3.5.4	\N	\N	5080936299
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2023-01-30 12:15:38.993937	87	EXECUTED	7:578d0b92077eaf2ab95ad0ec087aa903	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	3.5.4	\N	\N	5080936299
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2023-01-30 12:15:39.002895	88	EXECUTED	7:c95abe90d962c57a09ecaee57972835d	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	3.5.4	\N	\N	5080936299
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-01-30 12:15:39.008221	89	EXECUTED	7:f1313bcc2994a5c4dc1062ed6d8282d3	addColumn tableName=REALM; customChange		\N	3.5.4	\N	\N	5080936299
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-01-30 12:15:39.014707	90	EXECUTED	7:90d763b52eaffebefbcbde55f269508b	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	3.5.4	\N	\N	5080936299
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-01-30 12:15:39.031311	91	EXECUTED	7:d554f0cb92b764470dccfa5e0014a7dd	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	5080936299
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-01-30 12:15:39.039171	92	EXECUTED	7:73193e3ab3c35cf0f37ccea3bf783764	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	3.5.4	\N	\N	5080936299
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-01-30 12:15:39.041056	93	MARK_RAN	7:90a1e74f92e9cbaa0c5eab80b8a037f3	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	3.5.4	\N	\N	5080936299
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-01-30 12:15:39.049854	94	EXECUTED	7:5b9248f29cd047c200083cc6d8388b16	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	3.5.4	\N	\N	5080936299
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-01-30 12:15:39.051843	95	MARK_RAN	7:64db59e44c374f13955489e8990d17a1	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	3.5.4	\N	\N	5080936299
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-01-30 12:15:39.056164	96	EXECUTED	7:329a578cdb43262fff975f0a7f6cda60	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	3.5.4	\N	\N	5080936299
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-01-30 12:15:39.099549	97	EXECUTED	7:fae0de241ac0fd0bbc2b380b85e4f567	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	5080936299
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-01-30 12:15:39.10172	98	MARK_RAN	7:075d54e9180f49bb0c64ca4218936e81	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	5080936299
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-01-30 12:15:39.112361	99	MARK_RAN	7:06499836520f4f6b3d05e35a59324910	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	5080936299
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-01-30 12:15:39.13042	100	EXECUTED	7:fad08e83c77d0171ec166bc9bc5d390a	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	5080936299
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-01-30 12:15:39.132372	101	MARK_RAN	7:3d2b23076e59c6f70bae703aa01be35b	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	5080936299
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-01-30 12:15:39.149478	102	EXECUTED	7:1a7f28ff8d9e53aeb879d76ea3d9341a	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	3.5.4	\N	\N	5080936299
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-01-30 12:15:39.15254	103	EXECUTED	7:2fd554456fed4a82c698c555c5b751b6	customChange		\N	3.5.4	\N	\N	5080936299
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2023-01-30 12:15:39.156554	104	EXECUTED	7:b06356d66c2790ecc2ae54ba0458397a	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	3.5.4	\N	\N	5080936299
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
master	915b86d6-b332-465f-8fa9-ba5b418a99f9	f
master	59cc55a2-6546-4336-a1ab-912f67a2c6fc	t
master	90cf12ed-750a-4662-bd69-6b864b05ace2	t
master	d0f8c9a9-c788-45f4-ac56-d7e64d8f93ea	t
master	502ac439-8ff9-453e-ba29-9a4237570961	f
master	393ea3e6-e9d9-4342-a7d3-adaf4dc1d3f1	f
master	3e636212-b475-4639-800d-f470e5d3591f	t
master	601f8f6b-6716-46a6-9876-f8cc3819219c	t
master	da1516d1-22e7-4e0f-adc0-2c5400dd469e	f
tyk	8b8b9069-4f66-4136-8a89-ff8b692f447d	f
tyk	e6381ff1-96dd-44a3-838e-29f2744ac2c2	t
tyk	588e3a10-afd5-4ab5-a94f-3e32b5be0df3	t
tyk	850092e2-1349-4254-af96-89013593e113	t
tyk	7ce2e83c-42a1-42cb-bdc7-6857083d9170	t
tyk	5906659a-867d-46e2-8fc3-b81eab6489c3	f
tyk	11da0f80-a834-438b-9b17-f4ef6fab7a87	t
tyk	a2536b85-7768-4c18-9d45-276565311401	t
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
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
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
bfcc3128-ef87-4b8b-ba09-98c8523acf90	master	f	${role_default-roles}	default-roles-master	master	\N	\N
39071732-3c50-42e6-8875-b59365b79e9e	master	f	${role_admin}	admin	master	\N	\N
fa4f4d9d-88db-4cc6-bcba-bb2629cae768	master	f	${role_create-realm}	create-realm	master	\N	\N
4b329d6f-bcda-460d-81bc-e96ded2cc59c	639adc27-e97e-45e9-92d1-1061133b4787	t	${role_create-client}	create-client	master	639adc27-e97e-45e9-92d1-1061133b4787	\N
4f11637e-e93e-4500-904e-28627834380a	639adc27-e97e-45e9-92d1-1061133b4787	t	${role_view-realm}	view-realm	master	639adc27-e97e-45e9-92d1-1061133b4787	\N
799058c6-e174-4491-91e8-10587ede54d5	639adc27-e97e-45e9-92d1-1061133b4787	t	${role_view-users}	view-users	master	639adc27-e97e-45e9-92d1-1061133b4787	\N
7db97161-6c77-4f75-bf1f-a0fd85ae3336	639adc27-e97e-45e9-92d1-1061133b4787	t	${role_view-clients}	view-clients	master	639adc27-e97e-45e9-92d1-1061133b4787	\N
d5e13cf0-50dc-46d6-9cd1-f8e7f6eeafef	639adc27-e97e-45e9-92d1-1061133b4787	t	${role_view-events}	view-events	master	639adc27-e97e-45e9-92d1-1061133b4787	\N
922366db-abaa-4e43-8e50-1747e038d954	639adc27-e97e-45e9-92d1-1061133b4787	t	${role_view-identity-providers}	view-identity-providers	master	639adc27-e97e-45e9-92d1-1061133b4787	\N
9d9edb85-af98-4cbb-8aad-92442ffb2cf6	639adc27-e97e-45e9-92d1-1061133b4787	t	${role_view-authorization}	view-authorization	master	639adc27-e97e-45e9-92d1-1061133b4787	\N
f642b76c-837c-441d-9537-bec56d709e7f	639adc27-e97e-45e9-92d1-1061133b4787	t	${role_manage-realm}	manage-realm	master	639adc27-e97e-45e9-92d1-1061133b4787	\N
221c68a6-7025-492d-b00d-d17641f2a053	639adc27-e97e-45e9-92d1-1061133b4787	t	${role_manage-users}	manage-users	master	639adc27-e97e-45e9-92d1-1061133b4787	\N
0c502dd4-5610-47e9-aa3c-30d98fa14c74	639adc27-e97e-45e9-92d1-1061133b4787	t	${role_manage-clients}	manage-clients	master	639adc27-e97e-45e9-92d1-1061133b4787	\N
eed83f13-8b78-49dd-84f0-ab63d731f02f	639adc27-e97e-45e9-92d1-1061133b4787	t	${role_manage-events}	manage-events	master	639adc27-e97e-45e9-92d1-1061133b4787	\N
e8857779-7344-42d4-a4f9-1fa14a0552b4	639adc27-e97e-45e9-92d1-1061133b4787	t	${role_manage-identity-providers}	manage-identity-providers	master	639adc27-e97e-45e9-92d1-1061133b4787	\N
e81cc60c-a3fd-4c0f-9ce0-d60bacaf9bfc	639adc27-e97e-45e9-92d1-1061133b4787	t	${role_manage-authorization}	manage-authorization	master	639adc27-e97e-45e9-92d1-1061133b4787	\N
80a4236c-6710-485e-8974-4dc0cbb19e0f	639adc27-e97e-45e9-92d1-1061133b4787	t	${role_query-users}	query-users	master	639adc27-e97e-45e9-92d1-1061133b4787	\N
f2ce803d-5089-405e-af73-cf932c5ae69a	639adc27-e97e-45e9-92d1-1061133b4787	t	${role_query-clients}	query-clients	master	639adc27-e97e-45e9-92d1-1061133b4787	\N
5b16aff4-4052-4c4d-b1a9-206bbbcdfc8a	639adc27-e97e-45e9-92d1-1061133b4787	t	${role_query-realms}	query-realms	master	639adc27-e97e-45e9-92d1-1061133b4787	\N
497a139e-c556-4901-82c4-296a1aa34ea1	639adc27-e97e-45e9-92d1-1061133b4787	t	${role_query-groups}	query-groups	master	639adc27-e97e-45e9-92d1-1061133b4787	\N
51e5a345-f8f9-47ef-9915-4e7c37826354	de00d1d1-50b2-45dd-982e-bc46453bb408	t	${role_view-profile}	view-profile	master	de00d1d1-50b2-45dd-982e-bc46453bb408	\N
d11a5602-5aca-4fd1-9e7d-232e48e3ffb9	de00d1d1-50b2-45dd-982e-bc46453bb408	t	${role_manage-account}	manage-account	master	de00d1d1-50b2-45dd-982e-bc46453bb408	\N
bb8e600a-baf2-45ea-ac7c-bd899be48c9e	de00d1d1-50b2-45dd-982e-bc46453bb408	t	${role_manage-account-links}	manage-account-links	master	de00d1d1-50b2-45dd-982e-bc46453bb408	\N
7cf5a9b4-165a-4eb9-aecd-3d068f9d138e	de00d1d1-50b2-45dd-982e-bc46453bb408	t	${role_view-applications}	view-applications	master	de00d1d1-50b2-45dd-982e-bc46453bb408	\N
1e44a5f9-e3b1-4ed6-94c1-7ef41f4c25ea	de00d1d1-50b2-45dd-982e-bc46453bb408	t	${role_view-consent}	view-consent	master	de00d1d1-50b2-45dd-982e-bc46453bb408	\N
7e67116b-5261-4162-aaf1-58abfa86c32a	de00d1d1-50b2-45dd-982e-bc46453bb408	t	${role_manage-consent}	manage-consent	master	de00d1d1-50b2-45dd-982e-bc46453bb408	\N
bfacbd77-f52d-42bb-8b4d-cd71790929e0	de00d1d1-50b2-45dd-982e-bc46453bb408	t	${role_delete-account}	delete-account	master	de00d1d1-50b2-45dd-982e-bc46453bb408	\N
a626cdf6-0c8c-4994-bd10-e81d24223565	ba6e35ab-d52f-4d61-aaab-83928a145710	t	${role_read-token}	read-token	master	ba6e35ab-d52f-4d61-aaab-83928a145710	\N
0ce5fb51-56c4-41cf-9ce3-0007d15a532a	639adc27-e97e-45e9-92d1-1061133b4787	t	${role_impersonation}	impersonation	master	639adc27-e97e-45e9-92d1-1061133b4787	\N
0e32413c-2b78-4863-9739-ab50d688a817	master	f	${role_offline-access}	offline_access	master	\N	\N
9338cb29-d046-40c9-bf3d-15094d377725	master	f	${role_uma_authorization}	uma_authorization	master	\N	\N
31710fdf-7885-4181-9ac4-758058d60c36	master	f	\N	user	master	\N	\N
cef07a1f-0fc4-48a6-9858-550465318c8a	master	f	\N	therapist	master	\N	\N
0183e391-1caf-4a42-adf6-ffc53d6b2c75	tyk	f	${role_default-roles}	default-roles-tyk	tyk	\N	\N
9280f142-11f9-41b1-8160-c293fd933b58	67575c50-2f33-4c82-8db8-65804d8fd5ba	t	${role_create-client}	create-client	master	67575c50-2f33-4c82-8db8-65804d8fd5ba	\N
40f1caa4-dd7c-40c3-ad55-d36c4aa8be14	67575c50-2f33-4c82-8db8-65804d8fd5ba	t	${role_view-realm}	view-realm	master	67575c50-2f33-4c82-8db8-65804d8fd5ba	\N
05571967-5196-423b-9cb3-03980048466d	67575c50-2f33-4c82-8db8-65804d8fd5ba	t	${role_view-users}	view-users	master	67575c50-2f33-4c82-8db8-65804d8fd5ba	\N
2ca9daef-ef35-454d-99c6-fd24bfb5d78a	67575c50-2f33-4c82-8db8-65804d8fd5ba	t	${role_view-clients}	view-clients	master	67575c50-2f33-4c82-8db8-65804d8fd5ba	\N
ecd7d993-c6a8-48d6-8ad8-e56424a60e1b	67575c50-2f33-4c82-8db8-65804d8fd5ba	t	${role_view-events}	view-events	master	67575c50-2f33-4c82-8db8-65804d8fd5ba	\N
a662900c-6c29-4b77-9c1c-ff9bbfa874fa	67575c50-2f33-4c82-8db8-65804d8fd5ba	t	${role_view-identity-providers}	view-identity-providers	master	67575c50-2f33-4c82-8db8-65804d8fd5ba	\N
9d42fdee-0619-4ea7-b3a7-999c381e4648	67575c50-2f33-4c82-8db8-65804d8fd5ba	t	${role_view-authorization}	view-authorization	master	67575c50-2f33-4c82-8db8-65804d8fd5ba	\N
965c508a-c84a-41c2-ab84-7d371f2babf1	67575c50-2f33-4c82-8db8-65804d8fd5ba	t	${role_manage-realm}	manage-realm	master	67575c50-2f33-4c82-8db8-65804d8fd5ba	\N
606acaf9-10f5-4553-9ef0-850d313348dc	67575c50-2f33-4c82-8db8-65804d8fd5ba	t	${role_manage-users}	manage-users	master	67575c50-2f33-4c82-8db8-65804d8fd5ba	\N
eff250a5-63f8-4897-8b2e-b12d38be0fa6	67575c50-2f33-4c82-8db8-65804d8fd5ba	t	${role_manage-clients}	manage-clients	master	67575c50-2f33-4c82-8db8-65804d8fd5ba	\N
f59c59b1-467f-4178-92dc-ed341bfbac63	67575c50-2f33-4c82-8db8-65804d8fd5ba	t	${role_manage-events}	manage-events	master	67575c50-2f33-4c82-8db8-65804d8fd5ba	\N
334bf5ed-024e-41b6-b9d8-05339d79bef1	67575c50-2f33-4c82-8db8-65804d8fd5ba	t	${role_manage-identity-providers}	manage-identity-providers	master	67575c50-2f33-4c82-8db8-65804d8fd5ba	\N
9b5f45de-3171-4694-82fe-dfef92f88b80	67575c50-2f33-4c82-8db8-65804d8fd5ba	t	${role_manage-authorization}	manage-authorization	master	67575c50-2f33-4c82-8db8-65804d8fd5ba	\N
ff9eb526-c558-4d04-8307-85633abf2b02	67575c50-2f33-4c82-8db8-65804d8fd5ba	t	${role_query-users}	query-users	master	67575c50-2f33-4c82-8db8-65804d8fd5ba	\N
57d3ccac-6e9a-42e4-9e11-107beb9f0eb1	67575c50-2f33-4c82-8db8-65804d8fd5ba	t	${role_query-clients}	query-clients	master	67575c50-2f33-4c82-8db8-65804d8fd5ba	\N
7a7c0d72-e83f-4301-a652-15fc3c862447	67575c50-2f33-4c82-8db8-65804d8fd5ba	t	${role_query-realms}	query-realms	master	67575c50-2f33-4c82-8db8-65804d8fd5ba	\N
07033fb5-9a86-49e6-b76a-0c1aa7705982	67575c50-2f33-4c82-8db8-65804d8fd5ba	t	${role_query-groups}	query-groups	master	67575c50-2f33-4c82-8db8-65804d8fd5ba	\N
0133c64c-8134-479b-a37a-595a67ca6045	c161713b-d494-4973-abbe-8bf73547f655	t	${role_realm-admin}	realm-admin	tyk	c161713b-d494-4973-abbe-8bf73547f655	\N
05e62aef-9d98-4d32-95c3-eccb7a46b06e	c161713b-d494-4973-abbe-8bf73547f655	t	${role_create-client}	create-client	tyk	c161713b-d494-4973-abbe-8bf73547f655	\N
38eec677-8bf0-400e-ac07-7f4bc3ba45f5	c161713b-d494-4973-abbe-8bf73547f655	t	${role_view-realm}	view-realm	tyk	c161713b-d494-4973-abbe-8bf73547f655	\N
1583729f-2be7-4a86-86da-473a8907e4f2	c161713b-d494-4973-abbe-8bf73547f655	t	${role_view-users}	view-users	tyk	c161713b-d494-4973-abbe-8bf73547f655	\N
ed6eaf11-709e-4349-8c96-7f9f357ee7bb	c161713b-d494-4973-abbe-8bf73547f655	t	${role_view-clients}	view-clients	tyk	c161713b-d494-4973-abbe-8bf73547f655	\N
14d8252f-8a34-41d4-8dee-458a498527cc	c161713b-d494-4973-abbe-8bf73547f655	t	${role_view-events}	view-events	tyk	c161713b-d494-4973-abbe-8bf73547f655	\N
3f159ed2-0795-4c74-99ac-2728167f3357	c161713b-d494-4973-abbe-8bf73547f655	t	${role_view-identity-providers}	view-identity-providers	tyk	c161713b-d494-4973-abbe-8bf73547f655	\N
4cc00c83-ecec-4baa-8b37-057468cb6711	c161713b-d494-4973-abbe-8bf73547f655	t	${role_view-authorization}	view-authorization	tyk	c161713b-d494-4973-abbe-8bf73547f655	\N
7bbef091-935f-41fc-b27d-6a785c43aa46	c161713b-d494-4973-abbe-8bf73547f655	t	${role_manage-realm}	manage-realm	tyk	c161713b-d494-4973-abbe-8bf73547f655	\N
f85ddac8-8e6b-4156-99db-10b8f3e5e911	c161713b-d494-4973-abbe-8bf73547f655	t	${role_manage-users}	manage-users	tyk	c161713b-d494-4973-abbe-8bf73547f655	\N
da236cb5-7a2d-4436-b40f-229360b2276d	c161713b-d494-4973-abbe-8bf73547f655	t	${role_manage-clients}	manage-clients	tyk	c161713b-d494-4973-abbe-8bf73547f655	\N
29c21d96-027a-49f4-b503-f54251e9dd5c	c161713b-d494-4973-abbe-8bf73547f655	t	${role_manage-events}	manage-events	tyk	c161713b-d494-4973-abbe-8bf73547f655	\N
fcad3a30-6dd9-47c3-9802-a7f9d85ebaa4	c161713b-d494-4973-abbe-8bf73547f655	t	${role_manage-identity-providers}	manage-identity-providers	tyk	c161713b-d494-4973-abbe-8bf73547f655	\N
8fa765d5-05b9-43db-8cc3-2887d5631ee3	c161713b-d494-4973-abbe-8bf73547f655	t	${role_manage-authorization}	manage-authorization	tyk	c161713b-d494-4973-abbe-8bf73547f655	\N
0c2fd3bb-d85f-4d88-a27a-65443a9a9b5a	c161713b-d494-4973-abbe-8bf73547f655	t	${role_query-users}	query-users	tyk	c161713b-d494-4973-abbe-8bf73547f655	\N
49387c80-bf6c-46a9-8ca6-4f42398a5231	c161713b-d494-4973-abbe-8bf73547f655	t	${role_query-clients}	query-clients	tyk	c161713b-d494-4973-abbe-8bf73547f655	\N
797a3b7c-40f3-4aab-82da-f30a29b7f9fd	c161713b-d494-4973-abbe-8bf73547f655	t	${role_query-realms}	query-realms	tyk	c161713b-d494-4973-abbe-8bf73547f655	\N
d5ddff1e-56e9-4a34-90fd-2b3cdebbc771	c161713b-d494-4973-abbe-8bf73547f655	t	${role_query-groups}	query-groups	tyk	c161713b-d494-4973-abbe-8bf73547f655	\N
274b4dc8-a0f6-4ed3-a3df-4e8dfb75bce7	e09542b3-c0dc-47cd-9188-1af7d04a87eb	t	${role_view-profile}	view-profile	tyk	e09542b3-c0dc-47cd-9188-1af7d04a87eb	\N
1095c55e-6274-4a41-a5cb-1303c103fa98	e09542b3-c0dc-47cd-9188-1af7d04a87eb	t	${role_manage-account}	manage-account	tyk	e09542b3-c0dc-47cd-9188-1af7d04a87eb	\N
e403fd20-2d2d-4c30-98f5-886c4fe18410	e09542b3-c0dc-47cd-9188-1af7d04a87eb	t	${role_manage-account-links}	manage-account-links	tyk	e09542b3-c0dc-47cd-9188-1af7d04a87eb	\N
849abb2b-4379-4ab0-ab69-26250f4a2aec	e09542b3-c0dc-47cd-9188-1af7d04a87eb	t	${role_view-applications}	view-applications	tyk	e09542b3-c0dc-47cd-9188-1af7d04a87eb	\N
442514a3-4526-4243-8a10-df8fec1626ef	e09542b3-c0dc-47cd-9188-1af7d04a87eb	t	${role_view-consent}	view-consent	tyk	e09542b3-c0dc-47cd-9188-1af7d04a87eb	\N
d41ac1ed-ea99-4914-ac57-4607d9fd8637	e09542b3-c0dc-47cd-9188-1af7d04a87eb	t	${role_manage-consent}	manage-consent	tyk	e09542b3-c0dc-47cd-9188-1af7d04a87eb	\N
3a8f4eac-8e8b-48b3-ace4-bbe82c826eb6	e09542b3-c0dc-47cd-9188-1af7d04a87eb	t	${role_delete-account}	delete-account	tyk	e09542b3-c0dc-47cd-9188-1af7d04a87eb	\N
31af4089-7502-4d98-b2d0-ad1165a49169	67575c50-2f33-4c82-8db8-65804d8fd5ba	t	${role_impersonation}	impersonation	master	67575c50-2f33-4c82-8db8-65804d8fd5ba	\N
6699f02c-f3ba-4ad6-a5f2-b9241e94a3db	c161713b-d494-4973-abbe-8bf73547f655	t	${role_impersonation}	impersonation	tyk	c161713b-d494-4973-abbe-8bf73547f655	\N
da89e1d2-8a8a-48a5-b040-8709607349c6	efb5ef39-2a2c-4313-b1f1-578e7061ba28	t	${role_read-token}	read-token	tyk	efb5ef39-2a2c-4313-b1f1-578e7061ba28	\N
cbdcaeb0-642f-4fc2-bc03-b45abd7cc0aa	tyk	f	${role_offline-access}	offline_access	tyk	\N	\N
19d73f5b-9f2f-447a-aa37-d3c493b5351d	tyk	f	${role_uma_authorization}	uma_authorization	tyk	\N	\N
b9e0c4ab-5749-44c4-88a4-1af8f7915634	tyk	f	\N	therapist	tyk	\N	\N
82e625af-47f0-4348-b7f8-f0383b043c2c	tyk	f	\N	user	tyk	\N	\N
e751ea88-535e-45a1-aa1e-ebc7555949d4	ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	t	\N	uma_protection	tyk	ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	\N
56fccecc-6fa6-464c-a4f1-64dd49e9dedc	5cb3b129-c24d-40f4-9bcb-191266ed00e0	t	\N	uma_protection	tyk	5cb3b129-c24d-40f4-9bcb-191266ed00e0	\N
9406fdf8-2fb4-4c37-a97e-86f2ffa6674b	5cb3b129-c24d-40f4-9bcb-191266ed00e0	t	\N	user	tyk	5cb3b129-c24d-40f4-9bcb-191266ed00e0	\N
9eddc240-6298-4c2a-858d-b92350a4d549	5cb3b129-c24d-40f4-9bcb-191266ed00e0	t	\N	therapist	tyk	5cb3b129-c24d-40f4-9bcb-191266ed00e0	\N
756e1230-3bd7-4940-9aac-d5045f83b88f	tyk	f	\N	patient	tyk	\N	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.migration_model (id, version, update_time) FROM stdin;
ua5uc	16.1.1	1675080941
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
d80b8ccd-fe20-4644-93f9-98cd3f0b2738	code	// by default, grants any permission associated with this policy\n$evaluation.grant();\n
9279b41e-3a65-4b57-8865-ba6a228606a5	defaultResourceType	urn:tyk-client:resources:default
4345616b-ab5d-408e-b680-14424ee0adf4	code	// by default, grants any permission associated with this policy\n$evaluation.grant();\n
56b2b109-8818-433a-9dcf-582ccb8901dd	defaultResourceType	urn:tyk-gateway:resources:default
469e0ae1-f365-4251-a453-922df7497d7f	roles	[{"id":"b9e0c4ab-5749-44c4-88a4-1af8f7915634","required":true},{"id":"9eddc240-6298-4c2a-858d-b92350a4d549","required":true}]
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
27e35994-cc54-4fe6-b770-600b3ed0bdcd	audience resolve	openid-connect	oidc-audience-resolve-mapper	43a35051-12de-44fe-bef9-e3fdc2cc9d10	\N
be49b06a-188c-4946-808b-cb1f3870bea7	locale	openid-connect	oidc-usermodel-attribute-mapper	6d0f8f9f-cf55-434f-a092-ec69d984fe8e	\N
b130e93e-aa48-4f51-8381-d0e710cd6878	role list	saml	saml-role-list-mapper	\N	59cc55a2-6546-4336-a1ab-912f67a2c6fc
b108942d-f273-42a0-b996-a3c76c411ad1	full name	openid-connect	oidc-full-name-mapper	\N	90cf12ed-750a-4662-bd69-6b864b05ace2
b9f7ebd8-852a-4ece-ac11-9c530937a548	family name	openid-connect	oidc-usermodel-property-mapper	\N	90cf12ed-750a-4662-bd69-6b864b05ace2
79d4d863-b7f1-4d31-acf2-b9d9ba8b830e	given name	openid-connect	oidc-usermodel-property-mapper	\N	90cf12ed-750a-4662-bd69-6b864b05ace2
7ec769da-67f0-4835-9ab2-309eea7e6376	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	90cf12ed-750a-4662-bd69-6b864b05ace2
6ed149dc-5037-477b-87d3-c867282cfaaf	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	90cf12ed-750a-4662-bd69-6b864b05ace2
adf15d7f-df2d-4523-ab3a-8719a259aa46	username	openid-connect	oidc-usermodel-property-mapper	\N	90cf12ed-750a-4662-bd69-6b864b05ace2
73e7c85c-0cb9-4b9c-8637-a4c50c40ca04	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	90cf12ed-750a-4662-bd69-6b864b05ace2
4b80e26e-499d-4d3e-bfbc-2ee16de1df0a	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	90cf12ed-750a-4662-bd69-6b864b05ace2
6dd4d7f1-8fb0-4113-b055-2a1e74b419b5	website	openid-connect	oidc-usermodel-attribute-mapper	\N	90cf12ed-750a-4662-bd69-6b864b05ace2
5ced8fbf-a6ea-4ab2-bd50-cc0aab0678dd	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	90cf12ed-750a-4662-bd69-6b864b05ace2
7c73b14c-177c-4206-9333-a0cef326cc9e	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	90cf12ed-750a-4662-bd69-6b864b05ace2
89e66c90-7963-4208-9088-2863f62404ac	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	90cf12ed-750a-4662-bd69-6b864b05ace2
5ddde2f5-1877-4f29-9fa3-a9d42d2d94d4	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	90cf12ed-750a-4662-bd69-6b864b05ace2
e9e573f7-0fcd-4310-9aed-f575b7f53375	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	90cf12ed-750a-4662-bd69-6b864b05ace2
3cdafe72-2d25-45c7-b0e5-a36f44c59e94	email	openid-connect	oidc-usermodel-property-mapper	\N	d0f8c9a9-c788-45f4-ac56-d7e64d8f93ea
a028720f-0c21-424d-9b07-77f7adf25e0f	email verified	openid-connect	oidc-usermodel-property-mapper	\N	d0f8c9a9-c788-45f4-ac56-d7e64d8f93ea
5ea46408-4061-405e-9ab3-6de503948fc4	address	openid-connect	oidc-address-mapper	\N	502ac439-8ff9-453e-ba29-9a4237570961
289429c0-e300-486e-adf7-6f994cf41f60	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	393ea3e6-e9d9-4342-a7d3-adaf4dc1d3f1
2df9d1b7-3051-400c-821c-827f5cf2b1c6	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	393ea3e6-e9d9-4342-a7d3-adaf4dc1d3f1
28616923-eb52-487e-a8ea-3095cb6d6cc4	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	3e636212-b475-4639-800d-f470e5d3591f
b3c04ea6-2484-43cd-aef9-432680bc7221	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	3e636212-b475-4639-800d-f470e5d3591f
bc3bbb27-b4c7-4573-a1c0-712b4fbccde0	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	3e636212-b475-4639-800d-f470e5d3591f
821d5e18-f02d-4bc6-b593-d30821540195	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	601f8f6b-6716-46a6-9876-f8cc3819219c
6ee0157d-acc5-4f06-89f0-3d6759eb9f20	upn	openid-connect	oidc-usermodel-property-mapper	\N	da1516d1-22e7-4e0f-adc0-2c5400dd469e
f5770038-492e-4e09-b596-6763b9d55e38	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	da1516d1-22e7-4e0f-adc0-2c5400dd469e
2066e190-7987-459e-8ed1-8f400bca8ef9	audience resolve	openid-connect	oidc-audience-resolve-mapper	66d4945b-46e4-4841-8984-3411b9c64288	\N
f1b5ca6d-6b80-4542-bb47-6d5115a9b9c7	role list	saml	saml-role-list-mapper	\N	0f6adf9b-de50-4b7e-af5a-460645696fa3
83e824d9-78f5-4989-a1f1-76a47e9e9197	full name	openid-connect	oidc-full-name-mapper	\N	e6381ff1-96dd-44a3-838e-29f2744ac2c2
7b31a57d-8a56-49d7-8c84-b75a7a860ede	family name	openid-connect	oidc-usermodel-property-mapper	\N	e6381ff1-96dd-44a3-838e-29f2744ac2c2
2d69ba18-ef22-4c5e-b9be-e36c1ae116db	given name	openid-connect	oidc-usermodel-property-mapper	\N	e6381ff1-96dd-44a3-838e-29f2744ac2c2
667f4d50-e7ca-4b1c-9af0-5da4c6e054ac	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	e6381ff1-96dd-44a3-838e-29f2744ac2c2
9dc3e398-398c-4f35-8d4c-f0b86a0000e3	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	e6381ff1-96dd-44a3-838e-29f2744ac2c2
befa5cbc-8c74-4ed0-9f56-efcd71644f80	username	openid-connect	oidc-usermodel-property-mapper	\N	e6381ff1-96dd-44a3-838e-29f2744ac2c2
9ffbbb1f-584b-46ba-9fd0-cdbac5217fb3	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	e6381ff1-96dd-44a3-838e-29f2744ac2c2
d47f358f-c29d-4fc9-8252-e4e8a9b8f752	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	e6381ff1-96dd-44a3-838e-29f2744ac2c2
e1db8ce8-d511-40ae-855f-b963b3f6d468	website	openid-connect	oidc-usermodel-attribute-mapper	\N	e6381ff1-96dd-44a3-838e-29f2744ac2c2
78de5896-e5d5-4424-9846-08e5f1b85e52	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	e6381ff1-96dd-44a3-838e-29f2744ac2c2
d16087dc-c613-4d09-9ce7-03ef5b7449d3	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	e6381ff1-96dd-44a3-838e-29f2744ac2c2
171dc67a-9185-454f-a772-fd48e5210315	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	e6381ff1-96dd-44a3-838e-29f2744ac2c2
c92867cd-beec-4895-880b-0c7f57c76f9d	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	e6381ff1-96dd-44a3-838e-29f2744ac2c2
cc2e2ad4-d3a1-4575-a75e-1420b92f3ffa	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	e6381ff1-96dd-44a3-838e-29f2744ac2c2
6d692fe5-b558-4f8a-864a-1a6bad14ab45	email	openid-connect	oidc-usermodel-property-mapper	\N	588e3a10-afd5-4ab5-a94f-3e32b5be0df3
1fabaecd-838b-42a0-bfc5-bbf758a234f1	email verified	openid-connect	oidc-usermodel-property-mapper	\N	588e3a10-afd5-4ab5-a94f-3e32b5be0df3
1fcbcd91-3bc9-4217-8c3d-d4f8f180ecd6	address	openid-connect	oidc-address-mapper	\N	11da0f80-a834-438b-9b17-f4ef6fab7a87
6e5c7691-01a2-471a-8286-ac3573b5983f	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	a2536b85-7768-4c18-9d45-276565311401
9f7658a3-76ee-4abe-a363-c9097bc572d1	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	a2536b85-7768-4c18-9d45-276565311401
b4ccd4b7-e9e9-4b9a-baa8-c17e5444723a	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	850092e2-1349-4254-af96-89013593e113
588b2b69-a9e9-4745-90af-8c98bf97b51e	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	850092e2-1349-4254-af96-89013593e113
342c2083-a6b9-4a9b-8ef7-c5452fc6415b	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	850092e2-1349-4254-af96-89013593e113
98d7aa8c-cb76-4138-9df4-4af9a5d1f5de	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	7ce2e83c-42a1-42cb-bdc7-6857083d9170
145113d5-48e6-45db-a135-5d25481de7e8	upn	openid-connect	oidc-usermodel-property-mapper	\N	5906659a-867d-46e2-8fc3-b81eab6489c3
c326ca56-c1e1-4d7f-bd60-ec25fb867add	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	5906659a-867d-46e2-8fc3-b81eab6489c3
2d3c18ff-e6ed-493c-a937-6fb0a5997d0c	locale	openid-connect	oidc-usermodel-attribute-mapper	ee928f89-93ce-4ca2-91db-e640b8f60fde	\N
4b84af16-39e5-4288-9667-c935dfc3d412	tyk-audience	openid-connect	oidc-audience-mapper	5cb3b129-c24d-40f4-9bcb-191266ed00e0	\N
ab167459-4ed4-4660-aa79-d2f89f8c2d53	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	\N
70a94ca2-2878-4168-a7c6-d9dd5a02cddb	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	\N
79172a51-ae8b-425a-8b19-1973ef52c98e	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	\N
4b47901d-d236-42a2-aaea-74f721b1b0e6	tyk	openid-connect	oidc-audience-mapper	ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	\N
d03d79cb-961c-4b94-ad1c-d8a19f771333	email	openid-connect	oidc-usermodel-property-mapper	\N	e6381ff1-96dd-44a3-838e-29f2744ac2c2
9dadf872-6565-4a2e-939b-124373894a3a	address	openid-connect	oidc-address-mapper	\N	e6381ff1-96dd-44a3-838e-29f2744ac2c2
62414b75-4e57-41aa-afb4-b3b2b44de15b	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	e6381ff1-96dd-44a3-838e-29f2744ac2c2
f50285f0-1edf-4b4d-ab74-f7a6ad76f0c2	email	openid-connect	oidc-usermodel-property-mapper	ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	\N
9f08d0ee-9a47-42a6-850d-f2d3de083326	address	openid-connect	oidc-address-mapper	ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	\N
ffd9810a-9042-49e1-938c-95040085a524	phone number	openid-connect	oidc-usermodel-attribute-mapper	ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	\N
cfcd8b14-e839-4020-b895-405c67a7d786	Role	openid-connect	oidc-usermodel-realm-role-mapper	ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
be49b06a-188c-4946-808b-cb1f3870bea7	true	userinfo.token.claim
be49b06a-188c-4946-808b-cb1f3870bea7	locale	user.attribute
be49b06a-188c-4946-808b-cb1f3870bea7	true	id.token.claim
be49b06a-188c-4946-808b-cb1f3870bea7	true	access.token.claim
be49b06a-188c-4946-808b-cb1f3870bea7	locale	claim.name
be49b06a-188c-4946-808b-cb1f3870bea7	String	jsonType.label
b130e93e-aa48-4f51-8381-d0e710cd6878	false	single
b130e93e-aa48-4f51-8381-d0e710cd6878	Basic	attribute.nameformat
b130e93e-aa48-4f51-8381-d0e710cd6878	Role	attribute.name
b108942d-f273-42a0-b996-a3c76c411ad1	true	userinfo.token.claim
b108942d-f273-42a0-b996-a3c76c411ad1	true	id.token.claim
b108942d-f273-42a0-b996-a3c76c411ad1	true	access.token.claim
b9f7ebd8-852a-4ece-ac11-9c530937a548	true	userinfo.token.claim
b9f7ebd8-852a-4ece-ac11-9c530937a548	lastName	user.attribute
b9f7ebd8-852a-4ece-ac11-9c530937a548	true	id.token.claim
b9f7ebd8-852a-4ece-ac11-9c530937a548	true	access.token.claim
b9f7ebd8-852a-4ece-ac11-9c530937a548	family_name	claim.name
b9f7ebd8-852a-4ece-ac11-9c530937a548	String	jsonType.label
79d4d863-b7f1-4d31-acf2-b9d9ba8b830e	true	userinfo.token.claim
79d4d863-b7f1-4d31-acf2-b9d9ba8b830e	firstName	user.attribute
79d4d863-b7f1-4d31-acf2-b9d9ba8b830e	true	id.token.claim
79d4d863-b7f1-4d31-acf2-b9d9ba8b830e	true	access.token.claim
79d4d863-b7f1-4d31-acf2-b9d9ba8b830e	given_name	claim.name
79d4d863-b7f1-4d31-acf2-b9d9ba8b830e	String	jsonType.label
7ec769da-67f0-4835-9ab2-309eea7e6376	true	userinfo.token.claim
7ec769da-67f0-4835-9ab2-309eea7e6376	middleName	user.attribute
7ec769da-67f0-4835-9ab2-309eea7e6376	true	id.token.claim
7ec769da-67f0-4835-9ab2-309eea7e6376	true	access.token.claim
7ec769da-67f0-4835-9ab2-309eea7e6376	middle_name	claim.name
7ec769da-67f0-4835-9ab2-309eea7e6376	String	jsonType.label
6ed149dc-5037-477b-87d3-c867282cfaaf	true	userinfo.token.claim
6ed149dc-5037-477b-87d3-c867282cfaaf	nickname	user.attribute
6ed149dc-5037-477b-87d3-c867282cfaaf	true	id.token.claim
6ed149dc-5037-477b-87d3-c867282cfaaf	true	access.token.claim
6ed149dc-5037-477b-87d3-c867282cfaaf	nickname	claim.name
6ed149dc-5037-477b-87d3-c867282cfaaf	String	jsonType.label
adf15d7f-df2d-4523-ab3a-8719a259aa46	true	userinfo.token.claim
adf15d7f-df2d-4523-ab3a-8719a259aa46	username	user.attribute
adf15d7f-df2d-4523-ab3a-8719a259aa46	true	id.token.claim
adf15d7f-df2d-4523-ab3a-8719a259aa46	true	access.token.claim
adf15d7f-df2d-4523-ab3a-8719a259aa46	preferred_username	claim.name
adf15d7f-df2d-4523-ab3a-8719a259aa46	String	jsonType.label
73e7c85c-0cb9-4b9c-8637-a4c50c40ca04	true	userinfo.token.claim
73e7c85c-0cb9-4b9c-8637-a4c50c40ca04	profile	user.attribute
73e7c85c-0cb9-4b9c-8637-a4c50c40ca04	true	id.token.claim
73e7c85c-0cb9-4b9c-8637-a4c50c40ca04	true	access.token.claim
73e7c85c-0cb9-4b9c-8637-a4c50c40ca04	profile	claim.name
73e7c85c-0cb9-4b9c-8637-a4c50c40ca04	String	jsonType.label
4b80e26e-499d-4d3e-bfbc-2ee16de1df0a	true	userinfo.token.claim
4b80e26e-499d-4d3e-bfbc-2ee16de1df0a	picture	user.attribute
4b80e26e-499d-4d3e-bfbc-2ee16de1df0a	true	id.token.claim
4b80e26e-499d-4d3e-bfbc-2ee16de1df0a	true	access.token.claim
4b80e26e-499d-4d3e-bfbc-2ee16de1df0a	picture	claim.name
4b80e26e-499d-4d3e-bfbc-2ee16de1df0a	String	jsonType.label
6dd4d7f1-8fb0-4113-b055-2a1e74b419b5	true	userinfo.token.claim
6dd4d7f1-8fb0-4113-b055-2a1e74b419b5	website	user.attribute
6dd4d7f1-8fb0-4113-b055-2a1e74b419b5	true	id.token.claim
6dd4d7f1-8fb0-4113-b055-2a1e74b419b5	true	access.token.claim
6dd4d7f1-8fb0-4113-b055-2a1e74b419b5	website	claim.name
6dd4d7f1-8fb0-4113-b055-2a1e74b419b5	String	jsonType.label
5ced8fbf-a6ea-4ab2-bd50-cc0aab0678dd	true	userinfo.token.claim
5ced8fbf-a6ea-4ab2-bd50-cc0aab0678dd	gender	user.attribute
5ced8fbf-a6ea-4ab2-bd50-cc0aab0678dd	true	id.token.claim
5ced8fbf-a6ea-4ab2-bd50-cc0aab0678dd	true	access.token.claim
5ced8fbf-a6ea-4ab2-bd50-cc0aab0678dd	gender	claim.name
5ced8fbf-a6ea-4ab2-bd50-cc0aab0678dd	String	jsonType.label
7c73b14c-177c-4206-9333-a0cef326cc9e	true	userinfo.token.claim
7c73b14c-177c-4206-9333-a0cef326cc9e	birthdate	user.attribute
7c73b14c-177c-4206-9333-a0cef326cc9e	true	id.token.claim
7c73b14c-177c-4206-9333-a0cef326cc9e	true	access.token.claim
7c73b14c-177c-4206-9333-a0cef326cc9e	birthdate	claim.name
7c73b14c-177c-4206-9333-a0cef326cc9e	String	jsonType.label
89e66c90-7963-4208-9088-2863f62404ac	true	userinfo.token.claim
89e66c90-7963-4208-9088-2863f62404ac	zoneinfo	user.attribute
89e66c90-7963-4208-9088-2863f62404ac	true	id.token.claim
89e66c90-7963-4208-9088-2863f62404ac	true	access.token.claim
89e66c90-7963-4208-9088-2863f62404ac	zoneinfo	claim.name
89e66c90-7963-4208-9088-2863f62404ac	String	jsonType.label
5ddde2f5-1877-4f29-9fa3-a9d42d2d94d4	true	userinfo.token.claim
5ddde2f5-1877-4f29-9fa3-a9d42d2d94d4	locale	user.attribute
5ddde2f5-1877-4f29-9fa3-a9d42d2d94d4	true	id.token.claim
5ddde2f5-1877-4f29-9fa3-a9d42d2d94d4	true	access.token.claim
5ddde2f5-1877-4f29-9fa3-a9d42d2d94d4	locale	claim.name
5ddde2f5-1877-4f29-9fa3-a9d42d2d94d4	String	jsonType.label
e9e573f7-0fcd-4310-9aed-f575b7f53375	true	userinfo.token.claim
e9e573f7-0fcd-4310-9aed-f575b7f53375	updatedAt	user.attribute
e9e573f7-0fcd-4310-9aed-f575b7f53375	true	id.token.claim
e9e573f7-0fcd-4310-9aed-f575b7f53375	true	access.token.claim
e9e573f7-0fcd-4310-9aed-f575b7f53375	updated_at	claim.name
e9e573f7-0fcd-4310-9aed-f575b7f53375	String	jsonType.label
3cdafe72-2d25-45c7-b0e5-a36f44c59e94	true	userinfo.token.claim
3cdafe72-2d25-45c7-b0e5-a36f44c59e94	email	user.attribute
3cdafe72-2d25-45c7-b0e5-a36f44c59e94	true	id.token.claim
3cdafe72-2d25-45c7-b0e5-a36f44c59e94	true	access.token.claim
3cdafe72-2d25-45c7-b0e5-a36f44c59e94	email	claim.name
3cdafe72-2d25-45c7-b0e5-a36f44c59e94	String	jsonType.label
a028720f-0c21-424d-9b07-77f7adf25e0f	true	userinfo.token.claim
a028720f-0c21-424d-9b07-77f7adf25e0f	emailVerified	user.attribute
a028720f-0c21-424d-9b07-77f7adf25e0f	true	id.token.claim
a028720f-0c21-424d-9b07-77f7adf25e0f	true	access.token.claim
a028720f-0c21-424d-9b07-77f7adf25e0f	email_verified	claim.name
a028720f-0c21-424d-9b07-77f7adf25e0f	boolean	jsonType.label
5ea46408-4061-405e-9ab3-6de503948fc4	formatted	user.attribute.formatted
5ea46408-4061-405e-9ab3-6de503948fc4	country	user.attribute.country
5ea46408-4061-405e-9ab3-6de503948fc4	postal_code	user.attribute.postal_code
5ea46408-4061-405e-9ab3-6de503948fc4	true	userinfo.token.claim
5ea46408-4061-405e-9ab3-6de503948fc4	street	user.attribute.street
5ea46408-4061-405e-9ab3-6de503948fc4	true	id.token.claim
5ea46408-4061-405e-9ab3-6de503948fc4	region	user.attribute.region
5ea46408-4061-405e-9ab3-6de503948fc4	true	access.token.claim
5ea46408-4061-405e-9ab3-6de503948fc4	locality	user.attribute.locality
289429c0-e300-486e-adf7-6f994cf41f60	true	userinfo.token.claim
289429c0-e300-486e-adf7-6f994cf41f60	phoneNumber	user.attribute
289429c0-e300-486e-adf7-6f994cf41f60	true	id.token.claim
289429c0-e300-486e-adf7-6f994cf41f60	true	access.token.claim
289429c0-e300-486e-adf7-6f994cf41f60	phone_number	claim.name
289429c0-e300-486e-adf7-6f994cf41f60	String	jsonType.label
2df9d1b7-3051-400c-821c-827f5cf2b1c6	true	userinfo.token.claim
2df9d1b7-3051-400c-821c-827f5cf2b1c6	phoneNumberVerified	user.attribute
2df9d1b7-3051-400c-821c-827f5cf2b1c6	true	id.token.claim
2df9d1b7-3051-400c-821c-827f5cf2b1c6	true	access.token.claim
2df9d1b7-3051-400c-821c-827f5cf2b1c6	phone_number_verified	claim.name
2df9d1b7-3051-400c-821c-827f5cf2b1c6	boolean	jsonType.label
28616923-eb52-487e-a8ea-3095cb6d6cc4	true	multivalued
28616923-eb52-487e-a8ea-3095cb6d6cc4	foo	user.attribute
28616923-eb52-487e-a8ea-3095cb6d6cc4	true	access.token.claim
28616923-eb52-487e-a8ea-3095cb6d6cc4	realm_access.roles	claim.name
28616923-eb52-487e-a8ea-3095cb6d6cc4	String	jsonType.label
b3c04ea6-2484-43cd-aef9-432680bc7221	true	multivalued
b3c04ea6-2484-43cd-aef9-432680bc7221	foo	user.attribute
b3c04ea6-2484-43cd-aef9-432680bc7221	true	access.token.claim
b3c04ea6-2484-43cd-aef9-432680bc7221	resource_access.${client_id}.roles	claim.name
b3c04ea6-2484-43cd-aef9-432680bc7221	String	jsonType.label
6ee0157d-acc5-4f06-89f0-3d6759eb9f20	true	userinfo.token.claim
6ee0157d-acc5-4f06-89f0-3d6759eb9f20	username	user.attribute
6ee0157d-acc5-4f06-89f0-3d6759eb9f20	true	id.token.claim
6ee0157d-acc5-4f06-89f0-3d6759eb9f20	true	access.token.claim
6ee0157d-acc5-4f06-89f0-3d6759eb9f20	upn	claim.name
6ee0157d-acc5-4f06-89f0-3d6759eb9f20	String	jsonType.label
f5770038-492e-4e09-b596-6763b9d55e38	true	multivalued
f5770038-492e-4e09-b596-6763b9d55e38	foo	user.attribute
f5770038-492e-4e09-b596-6763b9d55e38	true	id.token.claim
f5770038-492e-4e09-b596-6763b9d55e38	true	access.token.claim
f5770038-492e-4e09-b596-6763b9d55e38	groups	claim.name
f5770038-492e-4e09-b596-6763b9d55e38	String	jsonType.label
f1b5ca6d-6b80-4542-bb47-6d5115a9b9c7	false	single
f1b5ca6d-6b80-4542-bb47-6d5115a9b9c7	Basic	attribute.nameformat
f1b5ca6d-6b80-4542-bb47-6d5115a9b9c7	Role	attribute.name
83e824d9-78f5-4989-a1f1-76a47e9e9197	true	userinfo.token.claim
83e824d9-78f5-4989-a1f1-76a47e9e9197	true	id.token.claim
83e824d9-78f5-4989-a1f1-76a47e9e9197	true	access.token.claim
7b31a57d-8a56-49d7-8c84-b75a7a860ede	true	userinfo.token.claim
7b31a57d-8a56-49d7-8c84-b75a7a860ede	lastName	user.attribute
7b31a57d-8a56-49d7-8c84-b75a7a860ede	true	id.token.claim
7b31a57d-8a56-49d7-8c84-b75a7a860ede	true	access.token.claim
7b31a57d-8a56-49d7-8c84-b75a7a860ede	family_name	claim.name
7b31a57d-8a56-49d7-8c84-b75a7a860ede	String	jsonType.label
2d69ba18-ef22-4c5e-b9be-e36c1ae116db	true	userinfo.token.claim
2d69ba18-ef22-4c5e-b9be-e36c1ae116db	firstName	user.attribute
2d69ba18-ef22-4c5e-b9be-e36c1ae116db	true	id.token.claim
2d69ba18-ef22-4c5e-b9be-e36c1ae116db	true	access.token.claim
2d69ba18-ef22-4c5e-b9be-e36c1ae116db	given_name	claim.name
2d69ba18-ef22-4c5e-b9be-e36c1ae116db	String	jsonType.label
667f4d50-e7ca-4b1c-9af0-5da4c6e054ac	true	userinfo.token.claim
667f4d50-e7ca-4b1c-9af0-5da4c6e054ac	middleName	user.attribute
667f4d50-e7ca-4b1c-9af0-5da4c6e054ac	true	id.token.claim
667f4d50-e7ca-4b1c-9af0-5da4c6e054ac	true	access.token.claim
667f4d50-e7ca-4b1c-9af0-5da4c6e054ac	middle_name	claim.name
667f4d50-e7ca-4b1c-9af0-5da4c6e054ac	String	jsonType.label
9dc3e398-398c-4f35-8d4c-f0b86a0000e3	true	userinfo.token.claim
9dc3e398-398c-4f35-8d4c-f0b86a0000e3	nickname	user.attribute
9dc3e398-398c-4f35-8d4c-f0b86a0000e3	true	id.token.claim
9dc3e398-398c-4f35-8d4c-f0b86a0000e3	true	access.token.claim
9dc3e398-398c-4f35-8d4c-f0b86a0000e3	nickname	claim.name
9dc3e398-398c-4f35-8d4c-f0b86a0000e3	String	jsonType.label
befa5cbc-8c74-4ed0-9f56-efcd71644f80	true	userinfo.token.claim
befa5cbc-8c74-4ed0-9f56-efcd71644f80	username	user.attribute
befa5cbc-8c74-4ed0-9f56-efcd71644f80	true	id.token.claim
befa5cbc-8c74-4ed0-9f56-efcd71644f80	true	access.token.claim
befa5cbc-8c74-4ed0-9f56-efcd71644f80	preferred_username	claim.name
befa5cbc-8c74-4ed0-9f56-efcd71644f80	String	jsonType.label
9ffbbb1f-584b-46ba-9fd0-cdbac5217fb3	true	userinfo.token.claim
9ffbbb1f-584b-46ba-9fd0-cdbac5217fb3	profile	user.attribute
9ffbbb1f-584b-46ba-9fd0-cdbac5217fb3	true	id.token.claim
9ffbbb1f-584b-46ba-9fd0-cdbac5217fb3	true	access.token.claim
9ffbbb1f-584b-46ba-9fd0-cdbac5217fb3	profile	claim.name
9ffbbb1f-584b-46ba-9fd0-cdbac5217fb3	String	jsonType.label
d47f358f-c29d-4fc9-8252-e4e8a9b8f752	true	userinfo.token.claim
d47f358f-c29d-4fc9-8252-e4e8a9b8f752	picture	user.attribute
d47f358f-c29d-4fc9-8252-e4e8a9b8f752	true	id.token.claim
d47f358f-c29d-4fc9-8252-e4e8a9b8f752	true	access.token.claim
d47f358f-c29d-4fc9-8252-e4e8a9b8f752	picture	claim.name
d47f358f-c29d-4fc9-8252-e4e8a9b8f752	String	jsonType.label
e1db8ce8-d511-40ae-855f-b963b3f6d468	true	userinfo.token.claim
e1db8ce8-d511-40ae-855f-b963b3f6d468	website	user.attribute
e1db8ce8-d511-40ae-855f-b963b3f6d468	true	id.token.claim
e1db8ce8-d511-40ae-855f-b963b3f6d468	true	access.token.claim
e1db8ce8-d511-40ae-855f-b963b3f6d468	website	claim.name
e1db8ce8-d511-40ae-855f-b963b3f6d468	String	jsonType.label
78de5896-e5d5-4424-9846-08e5f1b85e52	true	userinfo.token.claim
78de5896-e5d5-4424-9846-08e5f1b85e52	gender	user.attribute
78de5896-e5d5-4424-9846-08e5f1b85e52	true	id.token.claim
78de5896-e5d5-4424-9846-08e5f1b85e52	true	access.token.claim
78de5896-e5d5-4424-9846-08e5f1b85e52	gender	claim.name
78de5896-e5d5-4424-9846-08e5f1b85e52	String	jsonType.label
d16087dc-c613-4d09-9ce7-03ef5b7449d3	true	userinfo.token.claim
d16087dc-c613-4d09-9ce7-03ef5b7449d3	birthdate	user.attribute
d16087dc-c613-4d09-9ce7-03ef5b7449d3	true	id.token.claim
d16087dc-c613-4d09-9ce7-03ef5b7449d3	true	access.token.claim
d16087dc-c613-4d09-9ce7-03ef5b7449d3	birthdate	claim.name
d16087dc-c613-4d09-9ce7-03ef5b7449d3	String	jsonType.label
171dc67a-9185-454f-a772-fd48e5210315	true	userinfo.token.claim
171dc67a-9185-454f-a772-fd48e5210315	zoneinfo	user.attribute
171dc67a-9185-454f-a772-fd48e5210315	true	id.token.claim
171dc67a-9185-454f-a772-fd48e5210315	true	access.token.claim
171dc67a-9185-454f-a772-fd48e5210315	zoneinfo	claim.name
171dc67a-9185-454f-a772-fd48e5210315	String	jsonType.label
c92867cd-beec-4895-880b-0c7f57c76f9d	true	userinfo.token.claim
c92867cd-beec-4895-880b-0c7f57c76f9d	locale	user.attribute
c92867cd-beec-4895-880b-0c7f57c76f9d	true	id.token.claim
c92867cd-beec-4895-880b-0c7f57c76f9d	true	access.token.claim
c92867cd-beec-4895-880b-0c7f57c76f9d	locale	claim.name
c92867cd-beec-4895-880b-0c7f57c76f9d	String	jsonType.label
cc2e2ad4-d3a1-4575-a75e-1420b92f3ffa	true	userinfo.token.claim
cc2e2ad4-d3a1-4575-a75e-1420b92f3ffa	updatedAt	user.attribute
cc2e2ad4-d3a1-4575-a75e-1420b92f3ffa	true	id.token.claim
cc2e2ad4-d3a1-4575-a75e-1420b92f3ffa	true	access.token.claim
cc2e2ad4-d3a1-4575-a75e-1420b92f3ffa	updated_at	claim.name
cc2e2ad4-d3a1-4575-a75e-1420b92f3ffa	String	jsonType.label
6d692fe5-b558-4f8a-864a-1a6bad14ab45	true	userinfo.token.claim
6d692fe5-b558-4f8a-864a-1a6bad14ab45	email	user.attribute
6d692fe5-b558-4f8a-864a-1a6bad14ab45	true	id.token.claim
6d692fe5-b558-4f8a-864a-1a6bad14ab45	true	access.token.claim
6d692fe5-b558-4f8a-864a-1a6bad14ab45	email	claim.name
6d692fe5-b558-4f8a-864a-1a6bad14ab45	String	jsonType.label
1fabaecd-838b-42a0-bfc5-bbf758a234f1	true	userinfo.token.claim
1fabaecd-838b-42a0-bfc5-bbf758a234f1	emailVerified	user.attribute
1fabaecd-838b-42a0-bfc5-bbf758a234f1	true	id.token.claim
1fabaecd-838b-42a0-bfc5-bbf758a234f1	true	access.token.claim
1fabaecd-838b-42a0-bfc5-bbf758a234f1	email_verified	claim.name
1fabaecd-838b-42a0-bfc5-bbf758a234f1	boolean	jsonType.label
1fcbcd91-3bc9-4217-8c3d-d4f8f180ecd6	country	user.attribute.country
1fcbcd91-3bc9-4217-8c3d-d4f8f180ecd6	postal_code	user.attribute.postal_code
1fcbcd91-3bc9-4217-8c3d-d4f8f180ecd6	true	userinfo.token.claim
1fcbcd91-3bc9-4217-8c3d-d4f8f180ecd6	street	user.attribute.street
1fcbcd91-3bc9-4217-8c3d-d4f8f180ecd6	true	id.token.claim
1fcbcd91-3bc9-4217-8c3d-d4f8f180ecd6	region	user.attribute.region
1fcbcd91-3bc9-4217-8c3d-d4f8f180ecd6	true	access.token.claim
1fcbcd91-3bc9-4217-8c3d-d4f8f180ecd6	locality	user.attribute.locality
6e5c7691-01a2-471a-8286-ac3573b5983f	true	userinfo.token.claim
6e5c7691-01a2-471a-8286-ac3573b5983f	true	id.token.claim
6e5c7691-01a2-471a-8286-ac3573b5983f	true	access.token.claim
6e5c7691-01a2-471a-8286-ac3573b5983f	String	jsonType.label
9f7658a3-76ee-4abe-a363-c9097bc572d1	true	userinfo.token.claim
9f7658a3-76ee-4abe-a363-c9097bc572d1	phoneNumberVerified	user.attribute
9f7658a3-76ee-4abe-a363-c9097bc572d1	true	id.token.claim
9f7658a3-76ee-4abe-a363-c9097bc572d1	true	access.token.claim
9f7658a3-76ee-4abe-a363-c9097bc572d1	phone_number_verified	claim.name
9f7658a3-76ee-4abe-a363-c9097bc572d1	boolean	jsonType.label
b4ccd4b7-e9e9-4b9a-baa8-c17e5444723a	true	multivalued
b4ccd4b7-e9e9-4b9a-baa8-c17e5444723a	foo	user.attribute
b4ccd4b7-e9e9-4b9a-baa8-c17e5444723a	true	access.token.claim
6e5c7691-01a2-471a-8286-ac3573b5983f	phone	claim.name
1fcbcd91-3bc9-4217-8c3d-d4f8f180ecd6	formatted	user.attribute.formatted
b4ccd4b7-e9e9-4b9a-baa8-c17e5444723a	realm_access.roles	claim.name
b4ccd4b7-e9e9-4b9a-baa8-c17e5444723a	String	jsonType.label
588b2b69-a9e9-4745-90af-8c98bf97b51e	true	multivalued
588b2b69-a9e9-4745-90af-8c98bf97b51e	foo	user.attribute
588b2b69-a9e9-4745-90af-8c98bf97b51e	true	access.token.claim
588b2b69-a9e9-4745-90af-8c98bf97b51e	resource_access.${client_id}.roles	claim.name
588b2b69-a9e9-4745-90af-8c98bf97b51e	String	jsonType.label
145113d5-48e6-45db-a135-5d25481de7e8	true	userinfo.token.claim
145113d5-48e6-45db-a135-5d25481de7e8	username	user.attribute
145113d5-48e6-45db-a135-5d25481de7e8	true	id.token.claim
145113d5-48e6-45db-a135-5d25481de7e8	true	access.token.claim
145113d5-48e6-45db-a135-5d25481de7e8	upn	claim.name
145113d5-48e6-45db-a135-5d25481de7e8	String	jsonType.label
c326ca56-c1e1-4d7f-bd60-ec25fb867add	true	multivalued
c326ca56-c1e1-4d7f-bd60-ec25fb867add	foo	user.attribute
c326ca56-c1e1-4d7f-bd60-ec25fb867add	true	id.token.claim
c326ca56-c1e1-4d7f-bd60-ec25fb867add	true	access.token.claim
c326ca56-c1e1-4d7f-bd60-ec25fb867add	groups	claim.name
c326ca56-c1e1-4d7f-bd60-ec25fb867add	String	jsonType.label
2d3c18ff-e6ed-493c-a937-6fb0a5997d0c	true	userinfo.token.claim
2d3c18ff-e6ed-493c-a937-6fb0a5997d0c	locale	user.attribute
2d3c18ff-e6ed-493c-a937-6fb0a5997d0c	true	id.token.claim
2d3c18ff-e6ed-493c-a937-6fb0a5997d0c	true	access.token.claim
2d3c18ff-e6ed-493c-a937-6fb0a5997d0c	locale	claim.name
2d3c18ff-e6ed-493c-a937-6fb0a5997d0c	String	jsonType.label
4b84af16-39e5-4288-9667-c935dfc3d412	tyk-gateway	included.client.audience
4b84af16-39e5-4288-9667-c935dfc3d412	false	id.token.claim
4b84af16-39e5-4288-9667-c935dfc3d412	true	access.token.claim
ab167459-4ed4-4660-aa79-d2f89f8c2d53	clientId	user.session.note
ab167459-4ed4-4660-aa79-d2f89f8c2d53	true	id.token.claim
ab167459-4ed4-4660-aa79-d2f89f8c2d53	true	access.token.claim
ab167459-4ed4-4660-aa79-d2f89f8c2d53	clientId	claim.name
ab167459-4ed4-4660-aa79-d2f89f8c2d53	String	jsonType.label
70a94ca2-2878-4168-a7c6-d9dd5a02cddb	clientHost	user.session.note
70a94ca2-2878-4168-a7c6-d9dd5a02cddb	true	id.token.claim
70a94ca2-2878-4168-a7c6-d9dd5a02cddb	true	access.token.claim
70a94ca2-2878-4168-a7c6-d9dd5a02cddb	clientHost	claim.name
70a94ca2-2878-4168-a7c6-d9dd5a02cddb	String	jsonType.label
79172a51-ae8b-425a-8b19-1973ef52c98e	clientAddress	user.session.note
79172a51-ae8b-425a-8b19-1973ef52c98e	true	id.token.claim
79172a51-ae8b-425a-8b19-1973ef52c98e	true	access.token.claim
79172a51-ae8b-425a-8b19-1973ef52c98e	clientAddress	claim.name
79172a51-ae8b-425a-8b19-1973ef52c98e	String	jsonType.label
4b47901d-d236-42a2-aaea-74f721b1b0e6	false	id.token.claim
4b47901d-d236-42a2-aaea-74f721b1b0e6	true	access.token.claim
4b47901d-d236-42a2-aaea-74f721b1b0e6	tyk-gateway	included.client.audience
d03d79cb-961c-4b94-ad1c-d8a19f771333	true	userinfo.token.claim
d03d79cb-961c-4b94-ad1c-d8a19f771333	email	user.attribute
d03d79cb-961c-4b94-ad1c-d8a19f771333	true	id.token.claim
d03d79cb-961c-4b94-ad1c-d8a19f771333	true	access.token.claim
d03d79cb-961c-4b94-ad1c-d8a19f771333	email	claim.name
d03d79cb-961c-4b94-ad1c-d8a19f771333	String	jsonType.label
9dadf872-6565-4a2e-939b-124373894a3a	formatted	user.attribute.formatted
9dadf872-6565-4a2e-939b-124373894a3a	country	user.attribute.country
9dadf872-6565-4a2e-939b-124373894a3a	postal_code	user.attribute.postal_code
9dadf872-6565-4a2e-939b-124373894a3a	true	userinfo.token.claim
9dadf872-6565-4a2e-939b-124373894a3a	street	user.attribute.street
9dadf872-6565-4a2e-939b-124373894a3a	true	id.token.claim
9dadf872-6565-4a2e-939b-124373894a3a	region	user.attribute.region
9dadf872-6565-4a2e-939b-124373894a3a	true	access.token.claim
9dadf872-6565-4a2e-939b-124373894a3a	locality	user.attribute.locality
62414b75-4e57-41aa-afb4-b3b2b44de15b	true	userinfo.token.claim
62414b75-4e57-41aa-afb4-b3b2b44de15b	phoneNumber	user.attribute
62414b75-4e57-41aa-afb4-b3b2b44de15b	true	id.token.claim
62414b75-4e57-41aa-afb4-b3b2b44de15b	true	access.token.claim
62414b75-4e57-41aa-afb4-b3b2b44de15b	phone_number	claim.name
62414b75-4e57-41aa-afb4-b3b2b44de15b	String	jsonType.label
f50285f0-1edf-4b4d-ab74-f7a6ad76f0c2	true	userinfo.token.claim
f50285f0-1edf-4b4d-ab74-f7a6ad76f0c2	email	user.attribute
f50285f0-1edf-4b4d-ab74-f7a6ad76f0c2	true	id.token.claim
f50285f0-1edf-4b4d-ab74-f7a6ad76f0c2	true	access.token.claim
f50285f0-1edf-4b4d-ab74-f7a6ad76f0c2	email	claim.name
f50285f0-1edf-4b4d-ab74-f7a6ad76f0c2	String	jsonType.label
9f08d0ee-9a47-42a6-850d-f2d3de083326	formatted	user.attribute.formatted
9f08d0ee-9a47-42a6-850d-f2d3de083326	country	user.attribute.country
9f08d0ee-9a47-42a6-850d-f2d3de083326	postal_code	user.attribute.postal_code
9f08d0ee-9a47-42a6-850d-f2d3de083326	true	userinfo.token.claim
9f08d0ee-9a47-42a6-850d-f2d3de083326	street	user.attribute.street
9f08d0ee-9a47-42a6-850d-f2d3de083326	true	id.token.claim
9f08d0ee-9a47-42a6-850d-f2d3de083326	region	user.attribute.region
9f08d0ee-9a47-42a6-850d-f2d3de083326	true	access.token.claim
9f08d0ee-9a47-42a6-850d-f2d3de083326	locality	user.attribute.locality
ffd9810a-9042-49e1-938c-95040085a524	true	userinfo.token.claim
ffd9810a-9042-49e1-938c-95040085a524	phoneNumber	user.attribute
ffd9810a-9042-49e1-938c-95040085a524	true	id.token.claim
ffd9810a-9042-49e1-938c-95040085a524	true	access.token.claim
ffd9810a-9042-49e1-938c-95040085a524	phone_number	claim.name
ffd9810a-9042-49e1-938c-95040085a524	String	jsonType.label
cfcd8b14-e839-4020-b895-405c67a7d786	true	id.token.claim
cfcd8b14-e839-4020-b895-405c67a7d786	true	access.token.claim
cfcd8b14-e839-4020-b895-405c67a7d786	role	claim.name
cfcd8b14-e839-4020-b895-405c67a7d786	true	multivalued
cfcd8b14-e839-4020-b895-405c67a7d786	true	userinfo.token.claim
6e5c7691-01a2-471a-8286-ac3573b5983f	phone	user.attribute
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
tyk	60	300	3600000	\N	\N	\N	t	f	0	keywind	tyk	0	\N	f	t	t	f	EXTERNAL	180000	3600000	f	f	67575c50-2f33-4c82-8db8-65804d8fd5ba	180000	f	\N	f	f	f	t	0	1	30	6	HmacSHA1	totp	68e617f0-a3fa-4e54-b654-b5a7468de2dc	1089f8d7-909b-4ca2-aef9-98c5905607be	2164e41c-8c19-41c4-b7bd-2415c1e4c6e4	e80e515d-05c2-4f19-a225-d266513980cf	b58656b0-b4f5-4d11-b0c4-c29ac4d65c61	2592000	f	5400000	t	f	a9cd90cf-b269-49fd-b098-3cc7712031b6	0	f	0	0	0183e391-1caf-4a42-adf6-ffc53d6b2c75
master	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	639adc27-e97e-45e9-92d1-1061133b4787	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	2759373b-ad08-4fae-bbf2-407d3be938ef	8c7ae44f-e177-4ff4-8638-0bde1a03f034	12c2ea48-a47a-4aec-93ee-e0e76ebb1036	710ce88b-7e48-4443-bc75-6261c48c129f	dd1eb685-1e56-488a-a912-3134aa270089	2592000	f	900	t	f	0dca4dca-413a-4083-83da-b8c3474d18d8	0	f	0	0	bfcc3128-ef87-4b8b-ba09-98c8523acf90
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	master	
_browser_header.xContentTypeOptions	master	nosniff
_browser_header.xRobotsTag	master	none
_browser_header.xFrameOptions	master	SAMEORIGIN
_browser_header.contentSecurityPolicy	master	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	master	1; mode=block
_browser_header.strictTransportSecurity	master	max-age=31536000; includeSubDomains
bruteForceProtected	master	false
permanentLockout	master	false
maxFailureWaitSeconds	master	900
minimumQuickLoginWaitSeconds	master	60
waitIncrementSeconds	master	60
quickLoginCheckMilliSeconds	master	1000
maxDeltaTimeSeconds	master	43200
failureFactor	master	30
displayName	master	Keycloak
displayNameHtml	master	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	master	RS256
offlineSessionMaxLifespanEnabled	master	false
offlineSessionMaxLifespan	master	5184000
oauth2DeviceCodeLifespan	tyk	600
oauth2DevicePollingInterval	tyk	5
cibaBackchannelTokenDeliveryMode	tyk	poll
cibaExpiresIn	tyk	120
cibaInterval	tyk	5
cibaAuthRequestedUserHint	tyk	login_hint
parRequestUriLifespan	tyk	60
clientSessionIdleTimeout	tyk	0
clientSessionMaxLifespan	tyk	0
clientOfflineSessionIdleTimeout	tyk	0
clientOfflineSessionMaxLifespan	tyk	0
bruteForceProtected	tyk	false
permanentLockout	tyk	false
maxFailureWaitSeconds	tyk	900
minimumQuickLoginWaitSeconds	tyk	60
waitIncrementSeconds	tyk	60
quickLoginCheckMilliSeconds	tyk	1000
maxDeltaTimeSeconds	tyk	43200
failureFactor	tyk	30
actionTokenGeneratedByAdminLifespan	tyk	43200
actionTokenGeneratedByUserLifespan	tyk	300
defaultSignatureAlgorithm	tyk	RS256
offlineSessionMaxLifespanEnabled	tyk	false
offlineSessionMaxLifespan	tyk	5184000
webAuthnPolicyRpEntityName	tyk	keycloak
webAuthnPolicySignatureAlgorithms	tyk	ES256
webAuthnPolicyRpId	tyk	
webAuthnPolicyAttestationConveyancePreference	tyk	not specified
webAuthnPolicyAuthenticatorAttachment	tyk	not specified
webAuthnPolicyRequireResidentKey	tyk	not specified
webAuthnPolicyUserVerificationRequirement	tyk	not specified
webAuthnPolicyCreateTimeout	tyk	0
webAuthnPolicyAvoidSameAuthenticatorRegister	tyk	false
webAuthnPolicyRpEntityNamePasswordless	tyk	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	tyk	ES256
webAuthnPolicyRpIdPasswordless	tyk	
webAuthnPolicyAttestationConveyancePreferencePasswordless	tyk	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	tyk	not specified
webAuthnPolicyRequireResidentKeyPasswordless	tyk	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	tyk	not specified
webAuthnPolicyCreateTimeoutPasswordless	tyk	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	tyk	false
client-policies.profiles	tyk	{"profiles":[]}
client-policies.policies	tyk	{"policies":[]}
_browser_header.contentSecurityPolicyReportOnly	tyk	
_browser_header.xContentTypeOptions	tyk	nosniff
_browser_header.xRobotsTag	tyk	none
_browser_header.xFrameOptions	tyk	SAMEORIGIN
_browser_header.contentSecurityPolicy	tyk	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	tyk	1; mode=block
_browser_header.strictTransportSecurity	tyk	max-age=31536000; includeSubDomains
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
master	jboss-logging
tyk	jboss-logging
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
password	password	t	t	master
password	password	t	t	tyk
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
tyk	
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.redirect_uris (client_id, value) FROM stdin;
de00d1d1-50b2-45dd-982e-bc46453bb408	/realms/master/account/*
43a35051-12de-44fe-bef9-e3fdc2cc9d10	/realms/master/account/*
6d0f8f9f-cf55-434f-a092-ec69d984fe8e	/admin/master/console/*
e09542b3-c0dc-47cd-9188-1af7d04a87eb	/realms/tyk/account/*
66d4945b-46e4-4841-8984-3411b9c64288	/realms/tyk/account/*
ee928f89-93ce-4ca2-91db-e640b8f60fde	/admin/tyk/console/*
5cb3b129-c24d-40f4-9bcb-191266ed00e0	http://localhost:3000/
5cb3b129-c24d-40f4-9bcb-191266ed00e0	https://micare.ml/
ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	https://micare.ml
ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	http://localhost:3000/*
ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	http://localhost:3000
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
06edce8f-5662-4333-910e-d7f13b921722	VERIFY_EMAIL	Verify Email	master	t	f	VERIFY_EMAIL	50
40fdb01f-2cb5-403d-bab0-8cf87bb602ae	UPDATE_PROFILE	Update Profile	master	t	f	UPDATE_PROFILE	40
aa39a18a-a1aa-4a4b-9528-1193276ffa97	CONFIGURE_TOTP	Configure OTP	master	t	f	CONFIGURE_TOTP	10
aadf65fd-6809-4fe1-9e0f-c9bd5364f1a9	UPDATE_PASSWORD	Update Password	master	t	f	UPDATE_PASSWORD	30
78b1687f-9ed0-48cd-b5f0-517850ba7b5d	terms_and_conditions	Terms and Conditions	master	f	f	terms_and_conditions	20
5d7fa0b6-32e9-4dfa-83a9-2634cc7117cf	update_user_locale	Update User Locale	master	t	f	update_user_locale	1000
200ed8c3-fbac-4d8e-9b6a-cfb7a9325ea8	delete_account	Delete Account	master	f	f	delete_account	60
90e85fb1-2261-4237-b033-f8bb60e2bc2e	VERIFY_EMAIL	Verify Email	tyk	t	f	VERIFY_EMAIL	50
1555541e-178a-4d7f-9086-0276697d0c91	UPDATE_PROFILE	Update Profile	tyk	t	f	UPDATE_PROFILE	40
71d182d8-0a92-400e-af5c-0237f4e77d9b	CONFIGURE_TOTP	Configure OTP	tyk	t	f	CONFIGURE_TOTP	10
7df2d127-214c-49c8-9b59-cb9a76a49eff	UPDATE_PASSWORD	Update Password	tyk	t	f	UPDATE_PASSWORD	30
2086ef53-b0e8-4882-b51e-a3711b049f7a	terms_and_conditions	Terms and Conditions	tyk	f	f	terms_and_conditions	20
32870b29-25d5-46ff-a039-f5c95dfa51d6	update_user_locale	Update User Locale	tyk	t	f	update_user_locale	1000
d3bae2f2-62cc-47b3-a15b-361e19499b45	delete_account	Delete Account	tyk	f	f	delete_account	60
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
6f7e3b49-8200-4a2f-8f15-478f7c0c9c72	0414b119-19bf-4a84-9b05-9687e819a9df
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
6f7e3b49-8200-4a2f-8f15-478f7c0c9c72	5b135b2b-aeba-4698-805b-650f5cc2f2cb
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	t	0	1
5cb3b129-c24d-40f4-9bcb-191266ed00e0	t	0	1
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
d80b8ccd-fe20-4644-93f9-98cd3f0b2738	Default Policy	A policy that grants access only for users within this realm	js	0	0	ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	\N
9279b41e-3a65-4b57-8865-ba6a228606a5	Default Permission	A permission that applies to the default resource type	resource	1	0	ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	\N
4345616b-ab5d-408e-b680-14424ee0adf4	Default Policy	A policy that grants access only for users within this realm	js	0	0	5cb3b129-c24d-40f4-9bcb-191266ed00e0	\N
56b2b109-8818-433a-9dcf-582ccb8901dd	Default Permission	A permission that applies to the default resource type	resource	1	0	5cb3b129-c24d-40f4-9bcb-191266ed00e0	\N
469e0ae1-f365-4251-a453-922df7497d7f	TherapistRolePolicy	\N	role	1	0	5cb3b129-c24d-40f4-9bcb-191266ed00e0	\N
0414b119-19bf-4a84-9b05-9687e819a9df	SomministrazioniPermission	\N	resource	1	0	5cb3b129-c24d-40f4-9bcb-191266ed00e0	\N
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
485644f3-30b1-4bf9-9c5f-7363656171c9	Default Resource	urn:tyk-client:resources:default	\N	ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	f	\N
12d73531-6780-4786-95e8-57b093adf098	Default Resource	urn:tyk-gateway:resources:default	\N	5cb3b129-c24d-40f4-9bcb-191266ed00e0	5cb3b129-c24d-40f4-9bcb-191266ed00e0	f	\N
6f7e3b49-8200-4a2f-8f15-478f7c0c9c72	somministrazioni	resource:somministrazioni	\N	5cb3b129-c24d-40f4-9bcb-191266ed00e0	5cb3b129-c24d-40f4-9bcb-191266ed00e0	f	somministrazioni
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
5b135b2b-aeba-4698-805b-650f5cc2f2cb	read	\N	5cb3b129-c24d-40f4-9bcb-191266ed00e0	\N
eec372ab-3942-401d-8904-86bf614b642c	post	\N	5cb3b129-c24d-40f4-9bcb-191266ed00e0	\N
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_uris (resource_id, value) FROM stdin;
485644f3-30b1-4bf9-9c5f-7363656171c9	/*
12d73531-6780-4786-95e8-57b093adf098	/*
6f7e3b49-8200-4a2f-8f15-478f7c0c9c72	/somministrazioni
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
43a35051-12de-44fe-bef9-e3fdc2cc9d10	d11a5602-5aca-4fd1-9e7d-232e48e3ffb9
66d4945b-46e4-4841-8984-3411b9c64288	1095c55e-6274-4a41-a5cb-1303c103fa98
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
address	Via Roma 1, Milano	63b0bdc6-6e4c-457a-847c-6e6544ae57d0	6eac8253-b18c-4395-81cc-4f8500262b33
phone	3401234567	63b0bdc6-6e4c-457a-847c-6e6544ae57d0	3901a679-6375-48c8-b1d5-e407a2ffcad6
postal_code	22100	63b0bdc6-6e4c-457a-847c-6e6544ae57d0	90cf256b-dc0d-46a4-a5ed-85566248a82f
formatted	Via Roma 1, Milano	63b0bdc6-6e4c-457a-847c-6e6544ae57d0	6216ec74-3415-424c-b1b4-a326de422f7f
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
752d82f3-0255-453f-83ae-7c02a7d8d17a	\N	86424d57-2c21-4bea-87ce-eda964a49aac	f	t	\N	\N	\N	master	kcadmin	1675080943319	\N	0
67533f83-385b-4213-acf1-01068900c661	\N	a811c417-b918-42bc-9240-aee311268135	f	t	\N	\N	\N	tyk	service-account-tyk-gateway	1675257299294	5cb3b129-c24d-40f4-9bcb-191266ed00e0	0
ac84870e-daf1-4e94-9624-af912c579518	\N	5d2dbca6-819f-4854-a6d1-529711028d66	f	t	\N	\N	\N	master	testterapist	1675340316781	\N	0
18027302-6a1e-4e03-9f98-37c9c66430dd	\N	ddae81da-372b-4939-b9ec-9bb254a5a52f	f	t	\N	\N	\N	tyk	service-account-tyk-client	1675441920025	ef6c9c6f-87db-40f7-bca2-75cc2ed32bf6	0
c616335e-e575-46ec-96f1-93cb793ee70b	mrossi@test.it	mrossi@test.it	t	t	\N	Mario	Rossi	tyk	mrossi	1675700401205	\N	0
68557f5d-ecfc-4816-b711-52f7303497ea	testterapist@micare.ml	testterapist@micare.ml	f	t	\N	\N	\N	tyk	testterapist	1675358735221	\N	0
63b0bdc6-6e4c-457a-847c-6e6544ae57d0	elia.guarnieri@micare.ml	elia.guarnieri@micare.ml	t	t	\N	Elia	Guarnieri	tyk	eliag	1682774014454	\N	0
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
bfcc3128-ef87-4b8b-ba09-98c8523acf90	752d82f3-0255-453f-83ae-7c02a7d8d17a
39071732-3c50-42e6-8875-b59365b79e9e	752d82f3-0255-453f-83ae-7c02a7d8d17a
9280f142-11f9-41b1-8160-c293fd933b58	752d82f3-0255-453f-83ae-7c02a7d8d17a
40f1caa4-dd7c-40c3-ad55-d36c4aa8be14	752d82f3-0255-453f-83ae-7c02a7d8d17a
05571967-5196-423b-9cb3-03980048466d	752d82f3-0255-453f-83ae-7c02a7d8d17a
2ca9daef-ef35-454d-99c6-fd24bfb5d78a	752d82f3-0255-453f-83ae-7c02a7d8d17a
ecd7d993-c6a8-48d6-8ad8-e56424a60e1b	752d82f3-0255-453f-83ae-7c02a7d8d17a
a662900c-6c29-4b77-9c1c-ff9bbfa874fa	752d82f3-0255-453f-83ae-7c02a7d8d17a
9d42fdee-0619-4ea7-b3a7-999c381e4648	752d82f3-0255-453f-83ae-7c02a7d8d17a
965c508a-c84a-41c2-ab84-7d371f2babf1	752d82f3-0255-453f-83ae-7c02a7d8d17a
606acaf9-10f5-4553-9ef0-850d313348dc	752d82f3-0255-453f-83ae-7c02a7d8d17a
eff250a5-63f8-4897-8b2e-b12d38be0fa6	752d82f3-0255-453f-83ae-7c02a7d8d17a
f59c59b1-467f-4178-92dc-ed341bfbac63	752d82f3-0255-453f-83ae-7c02a7d8d17a
334bf5ed-024e-41b6-b9d8-05339d79bef1	752d82f3-0255-453f-83ae-7c02a7d8d17a
9b5f45de-3171-4694-82fe-dfef92f88b80	752d82f3-0255-453f-83ae-7c02a7d8d17a
ff9eb526-c558-4d04-8307-85633abf2b02	752d82f3-0255-453f-83ae-7c02a7d8d17a
57d3ccac-6e9a-42e4-9e11-107beb9f0eb1	752d82f3-0255-453f-83ae-7c02a7d8d17a
7a7c0d72-e83f-4301-a652-15fc3c862447	752d82f3-0255-453f-83ae-7c02a7d8d17a
07033fb5-9a86-49e6-b76a-0c1aa7705982	752d82f3-0255-453f-83ae-7c02a7d8d17a
0183e391-1caf-4a42-adf6-ffc53d6b2c75	67533f83-385b-4213-acf1-01068900c661
bfcc3128-ef87-4b8b-ba09-98c8523acf90	ac84870e-daf1-4e94-9624-af912c579518
b9e0c4ab-5749-44c4-88a4-1af8f7915634	68557f5d-ecfc-4816-b711-52f7303497ea
0183e391-1caf-4a42-adf6-ffc53d6b2c75	18027302-6a1e-4e03-9f98-37c9c66430dd
e751ea88-535e-45a1-aa1e-ebc7555949d4	18027302-6a1e-4e03-9f98-37c9c66430dd
56fccecc-6fa6-464c-a4f1-64dd49e9dedc	67533f83-385b-4213-acf1-01068900c661
b9e0c4ab-5749-44c4-88a4-1af8f7915634	63b0bdc6-6e4c-457a-847c-6e6544ae57d0
756e1230-3bd7-4940-9aac-d5045f83b88f	c616335e-e575-46ec-96f1-93cb793ee70b
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
6d0f8f9f-cf55-434f-a092-ec69d984fe8e	+
ee928f89-93ce-4ca2-91db-e640b8f60fde	+
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
-- Name: databasechangeloglock pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


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
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, ((value)::character varying(250)));


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

