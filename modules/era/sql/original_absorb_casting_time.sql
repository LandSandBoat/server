-- The update on December 19th 2006 changed the absorb spell casting times from four seconds to two seconds: http://www.playonline.com/pcd/update/ff11us/20061219WH3cX1/detail.html
-- It should be noted that the current game client will say the spells have a two second cast time

UPDATE spell_list
SET
  castTime = 4000
WHERE
  name IN (
    "absorb-str",
    "absorb-dex",
    "absorb-vit",
    "absorb-agi",
    "absorb-int",
    "absorb-mnd",
    "absorb-chr",
    "absorb-tp"
  );
