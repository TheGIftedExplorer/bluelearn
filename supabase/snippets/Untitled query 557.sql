WITH new_guide AS (
  INSERT INTO public.guide_bases (id, knowledge_type, created_at)
  VALUES (gen_random_uuid(), 'theoretical', NOW())
  RETURNING id
)
INSERT INTO public.guide_revisions (id, guide_id, title, summary, status, author_id, created_at)
SELECT 
  gen_random_uuid(),
  new_guide.id,
  'Sample Test Guide for Bug Review',
  'This is a fake guide generated for local testing.',
  'submitted',
  '6e1b12d6-12c7-4730-be7c-e29804069bc5',
  NOW()
FROM new_guide;