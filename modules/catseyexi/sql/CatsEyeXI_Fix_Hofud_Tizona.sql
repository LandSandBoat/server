-- MP Tizona (Band-aid fix)
INSERT INTO item_mods VALUES (19006, 431, 4);  -- MP ON HIT -- ITEM_ADDEFFECT_TYPE   = 431, // see procType table in scripts\globals\additional_effects.lua
INSERT INTO item_mods VALUES (19006, 499, 18); -- ITEM_SUBEFFECT                     = 499, // Animation ID of Spikes and Additional Effects
INSERT INTO item_mods VALUES (19006, 500, 20); -- 20 MP  -- ITEM_ADDEFFECT_DMG       = 500, // Damage of an items Additional Effect or Spikes
INSERT INTO item_mods VALUES (19006, 501, 20); -- 20%    -- ITEM_ADDEFFECT_CHANCE    = 501, // Chance of an items Additional Effect or Spikes
-- Hofud 
INSERT INTO item_mods VALUES (17745, 431, 8);  -- HP MP TP ON HIT -- ITEM_ADDEFFECT_TYPE   = 431, // see procType table in scripts\globals\additional_effects.lua
INSERT INTO item_mods VALUES (17745, 499, 22); -- ITEM_SUBEFFECT                     = 499, // Animation ID of Spikes and Additional Effects
INSERT INTO item_mods VALUES (17745, 500, 20); -- 20 HP or MP  -- ITEM_ADDEFFECT_DMG       = 500, // Damage of an items Additional Effect or Spikes
INSERT INTO item_mods VALUES (17745, 501, 20); -- 20%    -- ITEM_ADDEFFECT_CHANCE    = 501, // Chance of an items Additional Effect or Spikes
INSERT INTO item_mods VALUES (17745, 950, 8);  -- NEEDED ELEMENT TYPE 