-- ---------------------------------------------------------------------------
--  Notes: Adds content tags to prevent synths depending on if content is enabled or not
-- Format: (`ID`,`Desynth`,`KeyItem`,`Wood`,`Smith`,`Gold`,`Cloth`,`Leather`,`Bone`,`Alchemy`,
-- `Cook`,`Crystal`,`HQCrystal`,`Ingredient1`,`Ingredient2`,`Ingredient3`,`Ingredient4`,`Ingredient5`,
-- `Ingredient6`,`Ingredient7`,`Ingredient8`,`Result`,`ResultHQ1`,`ResultHQ2`,`ResultHQ3`,`ResultQty`,
-- `ResultHQ1Qty`,`ResultHQ2Qty`,`ResultHQ3Qty`,`ResultName`,`ContentTag`)
------------------------------------------------------------------------------

-- ------------------------------------------------------------
-- Add content_tag to recipes
-- ------------------------------------------------------------

LOCK TABLE `synth_recipes` WRITE;

ALTER TABLE `synth_recipes`
    ADD COLUMN IF NOT EXISTS `ContentTag` varchar(14) DEFAULT NULL AFTER `ResultName`;

-- ------------------------------------------------------------
-- ToAU Synths
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- WotG Synths
-- ------------------------------------------------------------

UPDATE synth_recipes SET ContentTag='WOTG' WHERE ResultName='Thalassocrat';

-- ------------------------------------------------------------
-- Abyssea Synths
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- SoA Synths
-- ------------------------------------------------------------

UNLOCK TABLES;
