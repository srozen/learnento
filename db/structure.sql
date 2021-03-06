--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.0
-- Dumped by pg_dump version 9.5.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: conversation_notifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE conversation_notifications (
    id integer NOT NULL,
    user_id integer,
    conversation_id integer,
    status boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: conversation_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE conversation_notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: conversation_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE conversation_notifications_id_seq OWNED BY conversation_notifications.id;


--
-- Name: conversations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE conversations (
    id integer NOT NULL,
    sender_id integer,
    recipient_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: conversations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE conversations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: conversations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE conversations_id_seq OWNED BY conversations.id;


--
-- Name: friendships; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE friendships (
    id integer NOT NULL,
    friendable_id integer,
    friendable_type character varying,
    friend_id integer,
    status character varying,
    message character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    blocker_id integer
);


--
-- Name: friendships_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE friendships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: friendships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE friendships_id_seq OWNED BY friendships.id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE messages (
    id integer NOT NULL,
    content text,
    conversation_id integer,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE messages_id_seq OWNED BY messages.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    first_name character varying,
    last_name character varying,
    avatar character varying,
    active_friend_notifications integer DEFAULT 0,
    active_messaging_notifications integer DEFAULT 0
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY conversation_notifications ALTER COLUMN id SET DEFAULT nextval('conversation_notifications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY conversations ALTER COLUMN id SET DEFAULT nextval('conversations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY friendships ALTER COLUMN id SET DEFAULT nextval('friendships_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY messages ALTER COLUMN id SET DEFAULT nextval('messages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: conversation_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY conversation_notifications
    ADD CONSTRAINT conversation_notifications_pkey PRIMARY KEY (id);


--
-- Name: conversations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY conversations
    ADD CONSTRAINT conversations_pkey PRIMARY KEY (id);


--
-- Name: friendships_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY friendships
    ADD CONSTRAINT friendships_pkey PRIMARY KEY (id);


--
-- Name: messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_conversation_notifications_on_conversation_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_conversation_notifications_on_conversation_id ON conversation_notifications USING btree (conversation_id);


--
-- Name: index_conversation_notifications_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_conversation_notifications_on_user_id ON conversation_notifications USING btree (user_id);


--
-- Name: index_conversations_on_recipient_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_conversations_on_recipient_id ON conversations USING btree (recipient_id);


--
-- Name: index_conversations_on_sender_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_conversations_on_sender_id ON conversations USING btree (sender_id);


--
-- Name: index_messages_on_conversation_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_messages_on_conversation_id ON messages USING btree (conversation_id);


--
-- Name: index_messages_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_messages_on_user_id ON messages USING btree (user_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: users_lower_first_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX users_lower_first_name ON users USING btree (lower((first_name)::text) varchar_pattern_ops);


--
-- Name: users_lower_last_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX users_lower_last_name ON users USING btree (lower((last_name)::text) varchar_pattern_ops);


--
-- Name: fk_rails_273a25a7a6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT fk_rails_273a25a7a6 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: fk_rails_7f927086d2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT fk_rails_7f927086d2 FOREIGN KEY (conversation_id) REFERENCES conversations(id);


--
-- Name: fk_rails_8a67f04c2c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY conversation_notifications
    ADD CONSTRAINT fk_rails_8a67f04c2c FOREIGN KEY (conversation_id) REFERENCES conversations(id);


--
-- Name: fk_rails_afc0a2a5ec; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY conversation_notifications
    ADD CONSTRAINT fk_rails_afc0a2a5ec FOREIGN KEY (user_id) REFERENCES users(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO schema_migrations (version) VALUES ('20160413113248');

INSERT INTO schema_migrations (version) VALUES ('20160413113712');

INSERT INTO schema_migrations (version) VALUES ('20160415094834');

INSERT INTO schema_migrations (version) VALUES ('20160415111731');

INSERT INTO schema_migrations (version) VALUES ('20160417104258');

INSERT INTO schema_migrations (version) VALUES ('20160417104259');

INSERT INTO schema_migrations (version) VALUES ('20160503085247');

INSERT INTO schema_migrations (version) VALUES ('20160505125652');

INSERT INTO schema_migrations (version) VALUES ('20160505151435');

INSERT INTO schema_migrations (version) VALUES ('20160505162420');

INSERT INTO schema_migrations (version) VALUES ('20160510083413');

