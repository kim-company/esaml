%% esaml - SAML for erlang
%%
%% Copyright (c) 2013, Alex Wilson and the University of Queensland
%% All rights reserved.
%%
%% Distributed subject to the terms of the 2-clause BSD license, see
%% the LICENSE file in the root of the distribution.

%% data types / message records

-include_lib("public_key/include/public_key.hrl").

-record(esaml_org, {
	name = "" :: esaml:localized_string(),
	displayname = "" :: esaml:localized_string(),
	url = "" :: esaml:localized_string()}).

-record(esaml_contact, {
	type = technical :: esaml:contact_type(),
	name = "" :: string(),
	email = "" :: string(),
	phone_number = [] :: [string()]}).

-record(esaml_sp_metadata, {
	org = #esaml_org{} :: esaml:org(),
	contacts = [] :: [esaml:contact()],
	signed_requests = true :: boolean(),
	signed_assertions = true :: boolean(),
	certificate :: binary() | undefined,
	cert_chain = [] :: [binary()],
	entity_id = "" :: string(),
	consumer_location = "" :: string(),
	logout_location :: string() | undefined}).

-record(esaml_idp_metadata, {
	org = #esaml_org{} :: esaml:org(),
	contacts = [] :: [esaml:contact()],
	signed_requests = true :: boolean(),
	certificate :: binary() | undefined,
	entity_id = "" :: string(),
	login_location = "" :: string(),
	logout_location :: string() | undefined,
	name_format = unknown :: esaml:name_format()}).

-record(esaml_authnreq, {
	version = "2.0" :: esaml:version(),
	issue_instant = "" :: esaml:datetime(),
	destination = "" :: string(),
	issuer = "" :: string(),
	name_format = undefined :: undefined | string(),
	consumer_location = "" :: string(),
	requested_context = unknown :: esaml:requested_authn_context()}).

-record(esaml_subject, {
	name = "" :: string(),
	name_qualifier = undefined :: undefined | string(),
	sp_name_qualifier = undefined :: undefined | string(),
	name_format = undefined :: undefined | string(),
	confirmation_method = bearer :: atom(),
	notonorafter = "" :: esaml:datetime(),
	in_response_to = "" :: string()}).

-record(esaml_assertion, {
	version = "2.0" :: esaml:version(),
	issue_instant = "" :: esaml:datetime(),
	recipient = "" :: string(),
	issuer = "" :: string(),
	subject = #esaml_subject{} :: esaml:subject(),
	conditions = [] :: esaml:conditions(),
	attributes = [] :: proplists:proplist(),
	authn = [] :: proplists:proplist()}).

-record(esaml_logoutreq, {
	version = "2.0" :: esaml:version(),
	issue_instant = "" :: esaml:datetime(),
	destination = "" :: string(),
	issuer = "" :: string(),
	name = "" :: string(),
	name_qualifier = undefined :: undefined | string(),
	sp_name_qualifier = undefined :: undefined | string(),
	name_format = undefined :: undefined | string(),
	session_index = "" :: string(),
	reason = user :: esaml:logout_reason()}).

-record(esaml_logoutresp, {
	version = "2.0" :: esaml:version(),
	issue_instant = "" :: esaml:datetime(),
	destination = "" :: string(),
	issuer = "" :: string(),
	status = unknown :: esaml:status_code()}).

-record(esaml_response, {
	version = "2.0" :: esaml:version(),
	issue_instant = "" :: esaml:datetime(),
	destination = "" :: string(),
	issuer = "" :: string(),
	status = unknown :: esaml:status_code(),
	assertion = #esaml_assertion{} :: esaml:assertion()}).

-record(esaml_requested_authn_context, {
	class_ref = [] :: [string()],
	decl_ref = [] :: [string()]}).

%% state records

-record(esaml_sp, {
	org = #esaml_org{} :: esaml:org(),
	contacts = [] :: [esaml:contact()],
	key :: #'RSAPrivateKey'{} | undefined,
	certificate :: binary() | undefined,
	cert_chain = [] :: [binary()],
	sp_sign_requests = false :: boolean(),
	idp_signs_assertions = true :: boolean(),
	idp_signs_envelopes = true :: boolean(),
	idp_signs_logout_requests = true :: boolean(),
	sp_sign_metadata = false :: boolean(),
	trusted_fingerprints = [] :: [string() | binary()],
	metadata_uri = "" :: string(),
	consume_uri = "" :: string(),
	logout_uri :: string() | undefined,
	encrypt_mandatory = false :: boolean(),
	entity_id :: string() | undefined,
	requested_context = unknown :: esaml:requested_authn_context()}).
