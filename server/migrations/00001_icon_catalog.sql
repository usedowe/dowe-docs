CREATE TABLE IF NOT EXISTS icon_categories (
  slug TEXT PRIMARY KEY,
  label TEXT NOT NULL,
  position INTEGER NOT NULL,
  count INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS icons (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  category TEXT NOT NULL,
  style TEXT NOT NULL,
  svg TEXT NOT NULL,
  UNIQUE(name, style),
  FOREIGN KEY(category) REFERENCES icon_categories(slug)
);

CREATE INDEX IF NOT EXISTS icons_category_style_name ON icons(category, style, name);
CREATE INDEX IF NOT EXISTS icons_name ON icons(name);

INSERT OR REPLACE INTO icon_categories (slug, label, position, count) VALUES ('arrows', 'Arrows', 0, 67);
INSERT OR REPLACE INTO icon_categories (slug, label, position, count) VALUES ('arrows-action', 'Arrows Action', 1, 58);
INSERT OR REPLACE INTO icon_categories (slug, label, position, count) VALUES ('astronomy', 'Astronomy', 2, 32);
INSERT OR REPLACE INTO icon_categories (slug, label, position, count) VALUES ('building', 'Building', 3, 7);
INSERT OR REPLACE INTO icon_categories (slug, label, position, count) VALUES ('business', 'Business', 4, 19);
INSERT OR REPLACE INTO icon_categories (slug, label, position, count) VALUES ('call', 'Call', 5, 21);
INSERT OR REPLACE INTO icon_categories (slug, label, position, count) VALUES ('devices', 'Devices', 6, 89);
INSERT OR REPLACE INTO icon_categories (slug, label, position, count) VALUES ('faces', 'Faces', 7, 21);
INSERT OR REPLACE INTO icon_categories (slug, label, position, count) VALUES ('files', 'Files', 8, 15);
INSERT OR REPLACE INTO icon_categories (slug, label, position, count) VALUES ('folders', 'Folders', 9, 14);
INSERT OR REPLACE INTO icon_categories (slug, label, position, count) VALUES ('food', 'Food', 10, 18);
INSERT OR REPLACE INTO icon_categories (slug, label, position, count) VALUES ('hands', 'Hands', 11, 5);
INSERT OR REPLACE INTO icon_categories (slug, label, position, count) VALUES ('home', 'Home', 12, 35);
INSERT OR REPLACE INTO icon_categories (slug, label, position, count) VALUES ('it', 'IT', 13, 31);
INSERT OR REPLACE INTO icon_categories (slug, label, position, count) VALUES ('like', 'Like', 14, 17);
INSERT OR REPLACE INTO icon_categories (slug, label, position, count) VALUES ('list', 'List', 15, 28);
INSERT OR REPLACE INTO icon_categories (slug, label, position, count) VALUES ('map', 'Map', 16, 37);
INSERT OR REPLACE INTO icon_categories (slug, label, position, count) VALUES ('medicine', 'Medicine', 17, 32);
INSERT OR REPLACE INTO icon_categories (slug, label, position, count) VALUES ('messages', 'Messages', 18, 48);
INSERT OR REPLACE INTO icon_categories (slug, label, position, count) VALUES ('money', 'Money', 19, 35);
INSERT OR REPLACE INTO icon_categories (slug, label, position, count) VALUES ('nature', 'Nature', 20, 9);
INSERT OR REPLACE INTO icon_categories (slug, label, position, count) VALUES ('notes', 'Notes', 21, 23);
INSERT OR REPLACE INTO icon_categories (slug, label, position, count) VALUES ('notifications', 'Notifications', 22, 7);
INSERT OR REPLACE INTO icon_categories (slug, label, position, count) VALUES ('parts', 'Parts', 23, 19);
INSERT OR REPLACE INTO icon_categories (slug, label, position, count) VALUES ('school', 'School', 24, 29);
INSERT OR REPLACE INTO icon_categories (slug, label, position, count) VALUES ('search', 'Search', 25, 12);
INSERT OR REPLACE INTO icon_categories (slug, label, position, count) VALUES ('security', 'Security', 26, 46);
INSERT OR REPLACE INTO icon_categories (slug, label, position, count) VALUES ('settings', 'Settings', 27, 15);
INSERT OR REPLACE INTO icon_categories (slug, label, position, count) VALUES ('shopping', 'Shopping', 28, 27);
INSERT OR REPLACE INTO icon_categories (slug, label, position, count) VALUES ('sports', 'Sports', 29, 41);
INSERT OR REPLACE INTO icon_categories (slug, label, position, count) VALUES ('text-formatting', 'Text Formatting', 30, 33);
INSERT OR REPLACE INTO icon_categories (slug, label, position, count) VALUES ('time', 'Time', 31, 27);
INSERT OR REPLACE INTO icon_categories (slug, label, position, count) VALUES ('tools', 'Tools', 32, 29);
INSERT OR REPLACE INTO icon_categories (slug, label, position, count) VALUES ('ui', 'UI', 33, 139);
INSERT OR REPLACE INTO icon_categories (slug, label, position, count) VALUES ('users', 'Users', 34, 22);
INSERT OR REPLACE INTO icon_categories (slug, label, position, count) VALUES ('video', 'Video', 35, 103);
INSERT OR REPLACE INTO icon_categories (slug, label, position, count) VALUES ('weather', 'Weather', 36, 36);
