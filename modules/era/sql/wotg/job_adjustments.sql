------------------------------------
-- Wings of the Goddess Job SQL Adjustments
-- This module reverts relevant SQL tables for jobs to their pre-WotG values
------------------------------------
-- Source : https://www.bg-wiki.com/ffxi/Version_Update_(04/08/2009)
------------------------------------

------------------------------------
-- White Mage
------------------------------------

-- Martyr: Revert range from 20 to 6 yalms
UPDATE `abilities` SET `range` = 6.0 WHERE `name` = 'martyr';

------------------------------------
-- Beastmaster
------------------------------------

-- Reward: Revert recast from 1 1/2 min to 3 minutes
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(03/11/2008)
UPDATE `abilities` SET `recastTime` = 180 WHERE `name` = 'reward';

-- Sic: Allow use with jug pets in addition to charmed mobs
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(11/09/2009)
UPDATE `abilities` SET `addType` = 192 WHERE `name` = 'sic';

-- Heel: Revert recast from 5 seconds to 10 seconds
-- Source: http://www.playonline.com/pcd/update/ff11us/20071120wwnX41/detail.html
UPDATE `abilities` SET `recastTime` = 10 WHERE `name` = 'heel';

-- Stay: Revert recast from 5 seconds to 10 seconds
UPDATE `abilities` SET `recastTime` = 10 WHERE `name` = 'stay';

-- Leave: Revert recast from 5 seconds to 10 seconds
UPDATE `abilities` SET `recastTime` = 10 WHERE `name` = 'leave';

-- Heel/Stay/Leave: Remove shared recast
UPDATE `abilities` set `recastId` = 152 WHERE `name` = 'heel';
UPDATE `abilities` set `recastId` = 153 WHERE `name` = 'leave';
UPDATE `abilities` set `recastId` = 154 WHERE `name` = 'stay';

-- Clean out existing entries for these skill lists.
-- These skills normally reference AbilityIDs for "Ready" moves but we need to directly use jugpet mobskill IDs for "Sic"
DELETE FROM `mob_skill_lists`
WHERE `skill_list_name` IN (
    'Jug_Hare',
    'Jug_Mandragora',
    'Jug_Tiger',
    'Jug_Lizard',
    'Jug_Sheep',
    'Jug_Crab',
    'Jug_Cactuar',
    'Jug_Funguar',
    'Jug_Beetle',
    'Jug_Fly',
    'Jug_Antlion',
    'Jug_Flytrap',
    'Jug_Eft',
    'Jug_Diremite'
);

INSERT INTO `mob_skill_lists` VALUES ('Jug_Hare',733,3840);       -- Foot Kick
INSERT INTO `mob_skill_lists` VALUES ('Jug_Hare',733,3841);       -- Dust Cloud
INSERT INTO `mob_skill_lists` VALUES ('Jug_Hare',733,3842);       -- Whirl Claws
INSERT INTO `mob_skill_lists` VALUES ('Jug_Mandragora',734,3843); -- Head Butt
INSERT INTO `mob_skill_lists` VALUES ('Jug_Mandragora',734,3844); -- Dream Flower
INSERT INTO `mob_skill_lists` VALUES ('Jug_Mandragora',734,3845); -- Wild Oats
INSERT INTO `mob_skill_lists` VALUES ('Jug_Mandragora',734,3846); -- Leaf Dagger
INSERT INTO `mob_skill_lists` VALUES ('Jug_Mandragora',734,3847); -- Scream
INSERT INTO `mob_skill_lists` VALUES ('Jug_Tiger',735,3848);      -- Roar
INSERT INTO `mob_skill_lists` VALUES ('Jug_Tiger',735,3849);      -- Razor Fang
INSERT INTO `mob_skill_lists` VALUES ('Jug_Tiger',735,3850);      -- Claw Cyclone
INSERT INTO `mob_skill_lists` VALUES ('Jug_Lizard',736,3851);     -- Tail Blow
INSERT INTO `mob_skill_lists` VALUES ('Jug_Lizard',736,3852);     -- Fireball
INSERT INTO `mob_skill_lists` VALUES ('Jug_Lizard',736,3853);     -- Blockhead
INSERT INTO `mob_skill_lists` VALUES ('Jug_Lizard',736,3854);     -- Brain Crush
INSERT INTO `mob_skill_lists` VALUES ('Jug_Lizard',736,3855);     -- Infrasonics
INSERT INTO `mob_skill_lists` VALUES ('Jug_Lizard',736,3856);     -- Secretion
INSERT INTO `mob_skill_lists` VALUES ('Jug_Sheep',737,3857);      -- Lamb Chop
INSERT INTO `mob_skill_lists` VALUES ('Jug_Sheep',737,3858);      -- Rage
INSERT INTO `mob_skill_lists` VALUES ('Jug_Sheep',737,3859);      -- Sheep Charge
INSERT INTO `mob_skill_lists` VALUES ('Jug_Sheep',737,3860);      -- Sheep Song
INSERT INTO `mob_skill_lists` VALUES ('Jug_Crab',738,3861);       -- Bubble Shower
INSERT INTO `mob_skill_lists` VALUES ('Jug_Crab',738,3862);       -- Bubble Curtain
INSERT INTO `mob_skill_lists` VALUES ('Jug_Crab',738,3863);       -- Big Scissors
INSERT INTO `mob_skill_lists` VALUES ('Jug_Crab',738,3864);       -- Scissor Guard
INSERT INTO `mob_skill_lists` VALUES ('Jug_Crab',738,3865);       -- Metallic Body
INSERT INTO `mob_skill_lists` VALUES ('Jug_Cactuar',739,3866);    -- Needle Shot
INSERT INTO `mob_skill_lists` VALUES ('Jug_Cactuar',739,3867);    -- ??? Needles (Another module reverts it to 1000 needles in function)
INSERT INTO `mob_skill_lists` VALUES ('Jug_Funguar',740,3868);    -- Frog Kick
INSERT INTO `mob_skill_lists` VALUES ('Jug_Funguar',740,3869);    -- Spore
INSERT INTO `mob_skill_lists` VALUES ('Jug_Funguar',740,3870);    -- Queasyshroom
INSERT INTO `mob_skill_lists` VALUES ('Jug_Funguar',740,3871);    -- Numbshroom
INSERT INTO `mob_skill_lists` VALUES ('Jug_Funguar',740,3872);    -- Shakeshroom
INSERT INTO `mob_skill_lists` VALUES ('Jug_Funguar',740,3873);    -- Silence Gas
INSERT INTO `mob_skill_lists` VALUES ('Jug_Funguar',740,3874);    -- Dark Spore
INSERT INTO `mob_skill_lists` VALUES ('Jug_Beetle',741,3875);     -- Power Attack (Beetle)
INSERT INTO `mob_skill_lists` VALUES ('Jug_Beetle',741,3876);     -- High-Freq Field
INSERT INTO `mob_skill_lists` VALUES ('Jug_Beetle',741,3877);     -- Rhino Attack
INSERT INTO `mob_skill_lists` VALUES ('Jug_Beetle',741,3878);     -- Rhino Guard
INSERT INTO `mob_skill_lists` VALUES ('Jug_Beetle',741,3879);     -- Spoil
INSERT INTO `mob_skill_lists` VALUES ('Jug_Fly',742,3880);        -- Cursed Sphere
INSERT INTO `mob_skill_lists` VALUES ('Jug_Fly',742,3881);        -- Venom
INSERT INTO `mob_skill_lists` VALUES ('Jug_Antlion',743,3882);    -- Sandblast
INSERT INTO `mob_skill_lists` VALUES ('Jug_Antlion',743,3883);    -- Sandpit
INSERT INTO `mob_skill_lists` VALUES ('Jug_Antlion',743,3884);    -- Venom Spray
INSERT INTO `mob_skill_lists` VALUES ('Jug_Antlion',743,3885);    -- Mandibular Bite
INSERT INTO `mob_skill_lists` VALUES ('Jug_Flytrap',744,3886);    -- Soporific
INSERT INTO `mob_skill_lists` VALUES ('Jug_Flytrap',744,3887);    -- Gloeosuccus
INSERT INTO `mob_skill_lists` VALUES ('Jug_Flytrap',744,3888);    -- Palsy Pollen
INSERT INTO `mob_skill_lists` VALUES ('Jug_Eft',745,3889);        -- Geist Wall
INSERT INTO `mob_skill_lists` VALUES ('Jug_Eft',745,3890);        -- Numbing Noise
INSERT INTO `mob_skill_lists` VALUES ('Jug_Eft',745,3891);        -- Nimble Snap
INSERT INTO `mob_skill_lists` VALUES ('Jug_Eft',745,3892);        -- Cyclotail
INSERT INTO `mob_skill_lists` VALUES ('Jug_Eft',745,3893);        -- Toxic Spit
INSERT INTO `mob_skill_lists` VALUES ('Jug_Diremite',746,3894);   -- Double Claw
INSERT INTO `mob_skill_lists` VALUES ('Jug_Diremite',746,3895);   -- Grapple
INSERT INTO `mob_skill_lists` VALUES ('Jug_Diremite',746,3896);   -- Filamented Hold
INSERT INTO `mob_skill_lists` VALUES ('Jug_Diremite',746,3897);   -- Spinning Top
