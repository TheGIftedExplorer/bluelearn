-- Step 1: Ensure a review case exists
WITH target_case AS (
  SELECT id FROM public.review_cases LIMIT 1
),
created_case AS (
  INSERT INTO public.review_cases (id)
  SELECT gen_random_uuid()
  WHERE NOT EXISTS (SELECT 1 FROM target_case)
  RETURNING id
),
-- Step 2: Ensure a review panel exists linked to the case
target_panel AS (
  SELECT id FROM public.review_panels LIMIT 1
),
created_panel AS (
  INSERT INTO public.review_panels (case_id, target_seat_count, opened_at)
  SELECT 
    COALESCE((SELECT id FROM target_case), (SELECT id FROM created_case)),
    3,
    NOW()
  WHERE NOT EXISTS (SELECT 1 FROM target_panel)
  RETURNING id
)
-- Step 3: Link user to the panel
INSERT INTO public.panel_members (panel_id, member_id, status)
SELECT 
  COALESCE((SELECT id FROM target_panel), (SELECT id FROM created_panel)),
  '6e1b12d6-12c7-4730-be7c-e29804069bc5'::uuid,
  'assigned'::seat_status
ON CONFLICT DO NOTHING;