WITH target_panel AS (
  SELECT id FROM public.panels LIMIT 1
),
created_panel AS (
  INSERT INTO public.panels DEFAULT VALUES
  WHERE NOT EXISTS (SELECT 1 FROM target_panel)
  RETURNING id
)
INSERT INTO public.panel_members (panel_id, member_id, status)
SELECT 
  COALESCE(
    (SELECT id FROM target_panel),
    (SELECT id FROM created_panel)
  ),
  '6e1b12d6-12c7-4730-be7c-e29804069bc5'::uuid,
  'assigned'::seat_status
ON CONFLICT DO NOTHING;