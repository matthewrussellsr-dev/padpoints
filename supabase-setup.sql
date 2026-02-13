-- ============================================================
-- PADPOINTS — SUPABASE DATABASE SETUP
-- ============================================================
-- Run this ONCE in your Supabase project's SQL Editor.
-- Go to: Supabase Dashboard → SQL Editor → New Query → paste → Run
-- ============================================================

-- Create the pins table
CREATE TABLE IF NOT EXISTS pins (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title       TEXT NOT NULL,
  description TEXT,
  category    TEXT DEFAULT 'pad',
  color       TEXT DEFAULT '#00FFB2',
  tags        TEXT,
  image_url   TEXT,
  x           NUMERIC(6,2) NOT NULL,  -- % from left edge of map image
  y           NUMERIC(6,2) NOT NULL,  -- % from top edge of map image
  created_at  TIMESTAMPTZ DEFAULT NOW(),
  updated_at  TIMESTAMPTZ DEFAULT NOW()
);

-- Auto-update the updated_at field
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER pins_updated_at
  BEFORE UPDATE ON pins
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at();

-- ============================================================
-- ROW LEVEL SECURITY (RLS)
-- ============================================================
-- Enable RLS (keeps data secure)
ALTER TABLE pins ENABLE ROW LEVEL SECURITY;

-- PUBLIC READ: Anyone visiting padpoints.com can read pins
CREATE POLICY "Public can read pins"
  ON pins FOR SELECT
  USING (true);

-- ANON INSERT/UPDATE/DELETE: Allowed via anon key
-- (Your admin.html uses the anon key — security comes from
--  the JS password gate, NOT from database-level auth.
--  This is fine for a personal site. For higher security,
--  upgrade to Supabase Auth later.)
CREATE POLICY "Anon can insert pins"
  ON pins FOR INSERT
  WITH CHECK (true);

CREATE POLICY "Anon can update pins"
  ON pins FOR UPDATE
  USING (true);

CREATE POLICY "Anon can delete pins"
  ON pins FOR DELETE
  USING (true);

-- ============================================================
-- REALTIME
-- ============================================================
-- Enable real-time updates so the map refreshes automatically
-- when you add pins in the admin panel
ALTER PUBLICATION supabase_realtime ADD TABLE pins;

-- ============================================================
-- SAMPLE DATA (optional — delete after testing)
-- ============================================================
INSERT INTO pins (title, description, category, color, tags, x, y) VALUES
  ('Example Pad A',    'Sample drill pad — replace with real data',    'pad',      '#00FFB2', 'oil, pad, prudhoe',    25.0, 40.0),
  ('Example Road 1',   'Gravel access road heading north',              'road',     '#00C4FF', 'road, gravel, access', 50.0, 55.0),
  ('Example Facility', 'Processing facility — sample entry',           'facility', '#FFD700', 'facility, processing', 72.0, 35.0);

-- ============================================================
-- DONE. You're ready to go.
-- ============================================================
