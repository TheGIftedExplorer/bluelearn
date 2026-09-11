INSERT INTO public.user_roles (user_id, role)
VALUES ('6e1b12d6-12c7-4730-be7c-e29804069bc5', 'verifier')
ON CONFLICT (user_id, role) DO NOTHING;