SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for blue_spell_mods
-- ----------------------------
DROP TABLE IF EXISTS `blue_spell_mods`;
CREATE TABLE `blue_spell_mods` (
  `spellId` smallint(3) unsigned NOT NULL,
  `modid` smallint(5) unsigned NOT NULL,
  `value` smallint(5) NOT NULL DEFAULT '0',
  PRIMARY KEY (`spellId`,`modid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Venom Shell
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('513', '13', '2'); -- MND+2

-- ----------------------------
-- Maelstrom
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('515', '13', '2'); -- MND+2

-- ----------------------------
-- Metallic Body
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('517', '0', '0'); -- No Stats

-- ----------------------------
-- Screwdriver
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('519', '10', '1'); -- VIT+1
INSERT INTO `blue_spell_mods` VALUES ('519', '14', '1'); -- CHR+1
INSERT INTO `blue_spell_mods` VALUES ('519', '2', '10'); -- HP+10

-- ----------------------------
-- MP Drainkiss
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('521', '5', '5'); -- MP+5

-- ----------------------------
-- Death Ray
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('522', '2', '-5'); -- HP-5
INSERT INTO `blue_spell_mods` VALUES ('522', '5', '5'); -- MP+5

-- ----------------------------
-- Sandspin
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('524', '10', '1'); -- VIT+1

-- ----------------------------
-- Smite Of Rage
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('527', '11', '3'); -- AGI+3

-- ----------------------------
-- Bludgeon
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('529', '8', '1'); -- STR+1

-- ----------------------------
-- Refueling
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('530', '11', '2'); -- AGI+2

-- ----------------------------
-- Ice Break
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('531', '12', '1'); -- INT+1

-- ----------------------------
-- Blitzstrahl
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('532', '9', '3'); -- DEX+3

-- ----------------------------
-- Self-Destruct
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('533', '8', '2'); -- STR+2

-- ----------------------------
-- Mysterious Light
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('534', '11', '3'); -- AGI+3

-- ----------------------------
-- Cold Wave
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('535', '12', '-1'); -- INT-1

-- ----------------------------
-- Poison Breath
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('536', '13', '1'); -- MND+1

-- ----------------------------
-- Stinking Gas
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('537', '11', '1'); -- AGI+1

-- ----------------------------
-- Memento Mori
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('538', '12', '1'); -- INT+1

-- ----------------------------
-- Terror Touch
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('539', '2', '-5'); -- HP-5
INSERT INTO `blue_spell_mods` VALUES ('539', '5', '10'); -- MP+10

-- ----------------------------
-- Spinal Cleave
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('540', '10', '2'); -- VIT+2
INSERT INTO `blue_spell_mods` VALUES ('540', '12', '1'); -- INT+1
INSERT INTO `blue_spell_mods` VALUES ('540', '13', '1'); -- MND+1

-- ----------------------------
-- Blood Saber
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('541', '2', '-5'); -- HP-5
INSERT INTO `blue_spell_mods` VALUES ('541', '5', '5'); -- MP+5

-- ----------------------------
-- Digest
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('542', '2', '-5'); -- HP-5
INSERT INTO `blue_spell_mods` VALUES ('542', '5', '5'); -- MP+5

-- ----------------------------
-- Mandibular Bite
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('543', '12', '1'); -- INT+1

-- ----------------------------
-- Cursed Sphere
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('544', '13', '1'); -- MND+1

-- ----------------------------
-- Sickle Slash
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('545', '2', '-5'); -- HP-5
INSERT INTO `blue_spell_mods` VALUES ('545', '5', '15'); -- MP+15

-- ----------------------------
-- Cocoon
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('547', '10', '3'); -- VIT+3

-- ----------------------------
-- Filamented Hold
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('548', '10', '1'); -- VIT+1

-- ----------------------------
-- Pollen
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('549', '2', '5'); -- HP+5
INSERT INTO `blue_spell_mods` VALUES ('549', '14', '1'); -- CHR+1

-- ----------------------------
-- Power Attack
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('551', '13', '1'); -- MND+1

-- ----------------------------
-- Death Scissors
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('554', '13', '2'); -- MND+2
INSERT INTO `blue_spell_mods` VALUES ('554', '14', '2'); -- CHR+2
INSERT INTO `blue_spell_mods` VALUES ('554', '2', '5'); -- HP+5

-- ----------------------------
-- Magnetite Cloud
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('555', '10', '2'); -- VIT+2

-- ----------------------------
-- Eyes On Me
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('557', '2', '-5'); -- HP-5
INSERT INTO `blue_spell_mods` VALUES ('557', '5', '15'); -- MP+15

-- ----------------------------
-- Frenetic Rip
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('560', '12', '1'); -- INT+1

-- ----------------------------
-- Frightful Roar
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('561', '11', '2'); -- AGI+2

-- ----------------------------
-- Hecatomb Wave
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('563', '11', '1'); -- AGI+1

-- ----------------------------
-- Body Slam
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('564', '10', '1'); -- VIT+1
INSERT INTO `blue_spell_mods` VALUES ('564', '5', '5'); -- MP+5

-- ----------------------------
-- Radiant Breath
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('565', '2', '5'); -- HP+5
INSERT INTO `blue_spell_mods` VALUES ('565', '14', '1'); -- CHR+1

-- ----------------------------
-- Helldive
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('567', '14', '1'); -- CHR+1
INSERT INTO `blue_spell_mods` VALUES ('567', '2', '5'); -- HP+5

-- ----------------------------
-- Jet Stream
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('569', '9', '2'); -- DEX+2

-- ----------------------------
-- Blood Drain
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('570', '2', '-5'); -- HP-5
INSERT INTO `blue_spell_mods` VALUES ('570', '5', '5'); -- MP+5

-- ----------------------------
-- Sound Blast
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('572', '0', '0'); -- No Stats

-- ----------------------------
-- Feather Tickle
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('573', '11', '1'); -- AGI+1

-- ----------------------------
-- Feather Barrier
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('574', '0', '0'); -- No Stats

-- ----------------------------
-- Jettatura
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('575', '5', '15'); -- MP+15

-- ----------------------------
-- Yawn
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('576', '2', '5'); -- HP+5
INSERT INTO `blue_spell_mods` VALUES ('576', '14', '1'); -- CHR+1

-- ----------------------------
-- Foot Kick
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('577', '11', '1'); -- AGI+1

-- ----------------------------
-- Wild Carrot
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('578', '2', '5'); -- HP+5

-- ----------------------------
-- Voracious Trunk
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('579', '11', '2'); -- AGI+2

-- ----------------------------
-- Healing Breeze
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('581', '2', '10'); -- HP+10
INSERT INTO `blue_spell_mods` VALUES ('581', '14', '1'); -- CHR+2

-- ----------------------------
-- Chaotic Eye
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('582', '11', '1'); -- AGI+1

-- ----------------------------
-- Sheep Song
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('584', '2', '5'); -- HP+5
INSERT INTO `blue_spell_mods` VALUES ('584', '14', '1'); -- CHR+1

-- ----------------------------
-- Ram Charge
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('585', '2', '5'); -- HP+5

-- ----------------------------
-- Claw Cyclone
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('587', '10', '1'); -- VIT+1

-- ----------------------------
-- Lowing
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('588', '2', '-5'); -- HP-5

-- ----------------------------
-- Dimensional Death
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('589', '9', '1'); -- DEX+1
INSERT INTO `blue_spell_mods` VALUES ('589', '14', '1'); -- CHR+1
INSERT INTO `blue_spell_mods` VALUES ('589', '2', '5'); -- HP+5

-- ----------------------------
-- Heat Breath
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('591', '8', '3'); -- STR+3

-- ----------------------------
-- Blank Gaze
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('592', '0', '0'); -- No Stats

-- ----------------------------
-- Magic Fruit
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('593', '14', '1'); -- CHR+1
INSERT INTO `blue_spell_mods` VALUES ('593', '2', '5'); -- HP+5

-- ----------------------------
-- Uppercut
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('594', '8', '2'); -- STR+2
INSERT INTO `blue_spell_mods` VALUES ('594', '9', '1'); -- DEX+1

-- ----------------------------
-- 1000 Needles
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('595', '10', '3'); -- VIT+3
INSERT INTO `blue_spell_mods` VALUES ('595', '11', '3'); -- AGI+3

-- ----------------------------
-- Pinecone Bomb
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('596', '8', '1'); -- STR+1

-- ----------------------------
-- Sprout Smack
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('597', '13', '1'); -- MND+1

-- ----------------------------
-- Soporific
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('598', '2', '-5'); -- HP-5
INSERT INTO `blue_spell_mods` VALUES ('598', '5', '5'); -- MP+5

-- ----------------------------
-- Queasyshroom
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('599', '2', '-5'); -- HP-5
INSERT INTO `blue_spell_mods` VALUES ('599', '5', '5'); -- MP+5

-- ----------------------------
-- Wild Oats
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('603', '14', '1'); -- CHR+1
INSERT INTO `blue_spell_mods` VALUES ('603', '2', '10'); -- HP+10

-- ----------------------------
-- Bad Breath
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('604', '12', '2'); -- INT+2
INSERT INTO `blue_spell_mods` VALUES ('604', '13', '2'); -- MND+2

-- ----------------------------
-- Geist Wall
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('605', '2', '-5'); -- HP-5
INSERT INTO `blue_spell_mods` VALUES ('605', '5', '10'); -- MP+10

-- ----------------------------
-- Awful Eye
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('606', '13', '1'); -- MND+1

-- ----------------------------
-- Frost Breath
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('608', '12', '-2'); -- INT-2

-- ----------------------------
-- Infrasonics
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('610', '12', '1'); -- INT+1

-- ----------------------------
-- Disseverment
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('611', '12', '1'); -- INT+1
INSERT INTO `blue_spell_mods` VALUES ('611', '13', '-1'); -- MND-1

-- ----------------------------
-- Actinic Burst
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('612', '2', '20'); -- HP+20
INSERT INTO `blue_spell_mods` VALUES ('612', '14', '2'); -- CHR+2

-- ----------------------------
-- Reactor Cool
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('613', '12', '3'); -- INT+3
INSERT INTO `blue_spell_mods` VALUES ('613', '13', '3'); -- MND+3

-- ----------------------------
-- Saline Coat
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('614', '5', '10'); -- MP+5
INSERT INTO `blue_spell_mods` VALUES ('614', '10', '2'); -- STR+2
INSERT INTO `blue_spell_mods` VALUES ('614', '11', '2'); -- DEX+2

-- ----------------------------
-- Plasma Charge
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('615', '8', '3'); -- STR+3
INSERT INTO `blue_spell_mods` VALUES ('615', '9', '3'); -- DEX+3

-- ----------------------------
-- Temporal Shift
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('616', '2', '20'); -- HP+10
INSERT INTO `blue_spell_mods` VALUES ('616', '5', '15'); -- MP+15

-- ----------------------------
-- Vertical Cleave
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('617', '10', '1'); -- STR+1
INSERT INTO `blue_spell_mods` VALUES ('617', '2', '-5'); -- HP-5
INSERT INTO `blue_spell_mods` VALUES ('617', '5', '5'); -- MP+5

-- ----------------------------
-- Blastbomb
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('618', '8', '1'); -- STR+1

-- ----------------------------
-- Battle Dance
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('620', '9', '2'); -- DEX+2

-- ----------------------------
-- Sandspray
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('621', '10', '1');  -- VIT+1

-- ----------------------------
-- Grand Slam
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('622', '12', '1'); -- INT+1

-- ----------------------------
-- Head Butt
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('623', '9', '2'); -- DEX+2

-- ----------------------------
-- Bomb Toss
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('626', '8', '2'); -- STR+2

-- ----------------------------
-- Frypan
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('628', '9', '2'); --  DEX+2

-- ----------------------------
-- Flying Hip Press
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('629', '11', '1'); -- AGI+1

-- ----------------------------
-- Hydro Shot
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('631', '13', '2'); -- MND+2

-- ----------------------------
-- Diamondhide
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('632', '10', '1'); -- VIT+1

-- ----------------------------
-- Enervation
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('633', '2', '-5'); -- HP-5
INSERT INTO `blue_spell_mods` VALUES ('633', '5', '5'); -- MP+5

-- ----------------------------
-- Light of Penance
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('634', '2', '15'); -- HP +15
INSERT INTO `blue_spell_mods` VALUES ('634', '14', '1'); -- CHR+1

-- ----------------------------
-- Warm-up
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('636', '10', '1'); -- VIT+1

-- ----------------------------
-- Firespit
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('637', '8', '3'); -- STR+3

-- ----------------------------
-- Feather Storm
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('638', '14', '2'); -- CHR+2
INSERT INTO `blue_spell_mods` VALUES ('638', '2', '5'); -- HP+5,

-- ----------------------------
-- Tail Slap
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('640', '13', '2'); -- MND+2

-- ----------------------------
-- Hysteric Barrage
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('641', '9', '2'); -- DEX+2
INSERT INTO `blue_spell_mods` VALUES ('641', '11', '1'); -- AGI+1

-- ----------------------------
-- Amplification
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('642', '2', '-5'); -- HP-5
INSERT INTO `blue_spell_mods` VALUES ('642', '5', '5'); -- MP+5

-- ----------------------------
-- Cannonball
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('643', '8', '1'); -- STR+1
INSERT INTO `blue_spell_mods` VALUES ('643', '9', '1'); -- DEX+1

-- ----------------------------
-- Mind Blast
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('644', '5', '5'); -- MP+5
INSERT INTO `blue_spell_mods` VALUES ('644', '13', '1'); -- MND+1

-- ----------------------------
-- Exuviation
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('645', '2', '5'); -- HP+5
INSERT INTO `blue_spell_mods` VALUES ('645', '5', '5'); -- MP+5
INSERT INTO `blue_spell_mods` VALUES ('645', '14', '1'); -- CHR+1

-- ----------------------------
-- Magic Hammer
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('646', '5', '-5'); -- MP-5
INSERT INTO `blue_spell_mods` VALUES ('646', '13', '2'); -- MND+2

-- ----------------------------
-- Zephyr Mantle
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('647', '11', '2'); -- AGI+2

-- ----------------------------
-- Regurgitation
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('648', '5', '3'); -- MP+3
INSERT INTO `blue_spell_mods` VALUES ('648', '12', '1'); -- INT+1
INSERT INTO `blue_spell_mods` VALUES ('648', '13', '1'); -- MND+1

-- ----------------------------
-- Seedspray
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('650', '10', '1'); --  VIT+1

-- ----------------------------
-- Corrosive Ooze
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('651', '2', '-10'); -- HP-10
INSERT INTO `blue_spell_mods` VALUES ('651', '5', '10'); -- MP+10

-- ----------------------------
-- Spiral Spin
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('652', '2', '5'); -- HP+5
INSERT INTO `blue_spell_mods` VALUES ('652', '8', '1'); -- STR+1

-- ----------------------------
-- Asuran Claws
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('653', '11', '3'); -- AGI+3

-- ----------------------------
-- Sub-zero Smash
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('654', '2', '10'); -- HP+10
INSERT INTO `blue_spell_mods` VALUES ('654', '10', '3'); -- VIT+3

-- ----------------------------
-- Triumphant Roar
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('655', '8', '3'); -- STR+3

-- ----------------------------
-- Acrid Stream
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('656', '9', '2'); -- DEX+2
INSERT INTO `blue_spell_mods` VALUES ('656', '13', '2'); -- MND+2

-- ----------------------------
-- Blazing Bound
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('657', '11', '1'); -- AGI+1
INSERT INTO `blue_spell_mods` VALUES ('657', '10', '2'); -- VIT+2

-- ----------------------------
-- Plenilune Embrace
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('658', '5', '5'); -- HP+5
INSERT INTO `blue_spell_mods` VALUES ('658', '8', '2'); -- STR+2

-- ----------------------------
-- Demoralizing Roar
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('659', '8', '-2'); -- STR-2
INSERT INTO `blue_spell_mods` VALUES ('659', '10', '3'); -- VIT+3

-- ----------------------------
-- Cimicine Discharge
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('660', '9', '1'); -- DEX+1
INSERT INTO `blue_spell_mods` VALUES ('660', '11', '2'); -- AGI+2

-- ----------------------------
-- Animating Wail
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('661', '2', '20'); -- HP+20

-- ----------------------------
-- Battery Charge
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('662', '5', '10'); -- MP+10
INSERT INTO `blue_spell_mods` VALUES ('662', '13', '1'); -- MND+1

-- ----------------------------
-- Leafstorm
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('663', '5', '3'); -- MP+3
INSERT INTO `blue_spell_mods` VALUES ('663', '13', '1'); -- MND+1
INSERT INTO `blue_spell_mods` VALUES ('663', '14', '1'); -- CHR+1

-- ----------------------------
-- Regeneration
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('664', '13', '2'); -- MND+2

-- ----------------------------
-- Final Sting
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('665', '2', '-20'); -- HP-20
INSERT INTO `blue_spell_mods` VALUES ('665', '11', '5'); -- AGI+5

-- ----------------------------
-- Goblin Rush
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('666', '2', '10'); -- HP+10
INSERT INTO `blue_spell_mods` VALUES ('666', '9', '2'); -- DEX+2
INSERT INTO `blue_spell_mods` VALUES ('666', '13', '-3'); -- MND-3

-- ----------------------------
-- Vanity Dive
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('667', '11', '3'); -- AGI+3
INSERT INTO `blue_spell_mods` VALUES ('667', '14', '-2'); -- CHR-2

-- ----------------------------
-- Magic Barrier
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('668', '5', '7'); -- MP+7
INSERT INTO `blue_spell_mods` VALUES ('668', '12', '2'); -- INT+2

-- ----------------------------
-- Whirl of Rage
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('669', '8', '2'); -- STR+2
INSERT INTO `blue_spell_mods` VALUES ('669', '9', '2'); -- DEX+2

-- ----------------------------
-- Benthic Typhoon
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('670', '8', '2'); -- STR+2
INSERT INTO `blue_spell_mods` VALUES ('670', '10', '2'); -- VIT+2
INSERT INTO `blue_spell_mods` VALUES ('670', '9', '-1'); -- DEX-1
INSERT INTO `blue_spell_mods` VALUES ('670', '11', '-1'); -- AGI-1

-- ----------------------------
-- Auroral Drape
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('671', '12', '3'); -- INT+3
INSERT INTO `blue_spell_mods` VALUES ('671', '14', '-2'); -- CHR-2

-- ----------------------------
-- Osmosis
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('672', '13', '3'); -- MND+3
INSERT INTO `blue_spell_mods` VALUES ('672', '14', '-2'); -- CHR-2

-- ----------------------------
-- Quad Continuum
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('673', '9', '3'); -- DEX+3
INSERT INTO `blue_spell_mods` VALUES ('673', '14', '-2'); -- CHR-2

-- ----------------------------
-- Fantod
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('674', '2', '-10'); -- HP-10
INSERT INTO `blue_spell_mods` VALUES ('674', '9', '2'); -- DEX+2
INSERT INTO `blue_spell_mods` VALUES ('674', '11', '2'); -- AGI+2

-- ----------------------------
-- Thermal Pulse
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('675', '10', '2'); -- VIT+2

-- ----------------------------
-- Empty Thrash
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('677', '8', '3'); -- STR+3
INSERT INTO `blue_spell_mods` VALUES ('677', '14', '-2'); -- CHR-2

-- ----------------------------
-- Dream Flower
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('678', '2', '5'); -- HP+5
INSERT INTO `blue_spell_mods` VALUES ('678', '5', '5'); -- MP+5
INSERT INTO `blue_spell_mods` VALUES ('678', '14', '2'); -- CHR+2

-- ----------------------------
-- Occultation
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('679', '10', '3'); -- VIT+3
INSERT INTO `blue_spell_mods` VALUES ('679', '14', '-2'); -- CHR-2

-- ----------------------------
-- Charged Whisker
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('680', '2', '-10'); -- HP-10
INSERT INTO `blue_spell_mods` VALUES ('680', '9', '2'); -- DEX+2
INSERT INTO `blue_spell_mods` VALUES ('680', '12', '2'); -- INT+2

-- ----------------------------
-- Winds of Promyvion
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('681', '13', '3'); -- MND+3
INSERT INTO `blue_spell_mods` VALUES ('681', '14', '-2'); -- CHR-2

-- ----------------------------
-- Delta Thrust
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('682', '2', '15'); -- HP+15
INSERT INTO `blue_spell_mods` VALUES ('682', '5', '-5'); -- MP-5
INSERT INTO `blue_spell_mods` VALUES ('682', '12', '-1'); -- INT-1

-- ----------------------------
-- Everyone's Grudge
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('683', '12', '2'); -- INT+2
INSERT INTO `blue_spell_mods` VALUES ('683', '13', '2'); -- MND+2
INSERT INTO `blue_spell_mods` VALUES ('683', '8', '-1'); -- STR-1
INSERT INTO `blue_spell_mods` VALUES ('683', '10', '-1'); -- VIT-1

-- ----------------------------
-- Reaving Wind
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('684', '8', '2'); -- STR+2
INSERT INTO `blue_spell_mods` VALUES ('684', '11', '2'); -- AGI+2

-- ----------------------------
-- Barrier Tusk
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('685', '2', '15'); -- HP+15
INSERT INTO `blue_spell_mods` VALUES ('685', '5', '-15'); -- MP-15
INSERT INTO `blue_spell_mods` VALUES ('685', '10', '3'); -- VIT+3

-- ----------------------------
-- Mortal Ray
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('686', '8', '2'); -- STR+2
INSERT INTO `blue_spell_mods` VALUES ('686', '13', '2'); -- MND+2

-- ----------------------------
-- Water Bomb
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('687', '5', '20'); -- MP+20
INSERT INTO `blue_spell_mods` VALUES ('687', '12', '4'); -- INT+4
INSERT INTO `blue_spell_mods` VALUES ('687', '13', '2'); -- MND+2
INSERT INTO `blue_spell_mods` VALUES ('687', '8', '-3'); -- STR-3
INSERT INTO `blue_spell_mods` VALUES ('687', '10', '-3'); -- VIT-3

-- ----------------------------
-- Heavy Strike
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('688', '8', '2'); -- STR+2

-- ----------------------------
-- Dark Orb
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('689', '11', '2'); -- AGI+2
INSERT INTO `blue_spell_mods` VALUES ('689', '13', '2'); -- MND+2

-- ----------------------------
-- White Wind
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('690', '2', '5'); -- HP+5
INSERT INTO `blue_spell_mods` VALUES ('690', '11', '1'); -- AGI+1

-- ----------------------------
-- Sudden Lunge
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('692', '2', '-5'); -- HP-5
INSERT INTO `blue_spell_mods` VALUES ('692', '5', '-5'); -- MP-5
INSERT INTO `blue_spell_mods` VALUES ('692', '11', '1'); -- AGI+1
INSERT INTO `blue_spell_mods` VALUES ('692', '9', '1'); -- DEX+1

-- ----------------------------
-- Quadrastrike
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('693', '8', '3'); -- STR+3
INSERT INTO `blue_spell_mods` VALUES ('693', '14', '3'); -- CHR+3

-- ----------------------------
-- Vapor Spray
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('694', '2', '15'); -- HP+15
INSERT INTO `blue_spell_mods` VALUES ('694', '10', '4'); -- VIT+4

-- ----------------------------
-- Thunder Breath
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('695', '8', '2'); -- STR+2
INSERT INTO `blue_spell_mods` VALUES ('695', '9', '2'); -- DEX+2

-- ----------------------------
-- Orcish Counterstance
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('696', '2', '10'); -- HP+10
INSERT INTO `blue_spell_mods` VALUES ('696', '8', '3'); -- STR+3
INSERT INTO `blue_spell_mods` VALUES ('696', '10', '3'); -- VIT+3
INSERT INTO `blue_spell_mods` VALUES ('696', '9', '-2'); -- DEX-2
INSERT INTO `blue_spell_mods` VALUES ('696', '11', '-2'); -- AGI-2

-- ----------------------------
-- Amorphic Spikes
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('697', '12', '5'); -- INT+5
INSERT INTO `blue_spell_mods` VALUES ('697', '13', '2'); -- MND+2

-- ----------------------------
-- Wind Breath
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('698', '8', '2'); -- STR+2
INSERT INTO `blue_spell_mods` VALUES ('698', '11', '2'); -- AGI+2

-- ----------------------------
-- Barbed Crescent
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('699', '8', '-3'); -- STR-3
INSERT INTO `blue_spell_mods` VALUES ('699', '9', '4'); -- DEX+4

-- ----------------------------
-- Nature's Meditation
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('700', '9', '6'); -- DEX+6

-- ----------------------------
-- Tempestuous Upheaval
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('701', '11', '6'); -- AGI+6

-- ----------------------------
-- Rending Deluge
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('702', '10', '6'); -- VIT+6

-- ----------------------------
-- Embalming Earth
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('703', '8', '6'); -- STR+6

-- ----------------------------
-- Paralyzing Triad
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('704', '2', '-10'); -- HP-10
INSERT INTO `blue_spell_mods` VALUES ('704', '8', '4'); -- STR+4
INSERT INTO `blue_spell_mods` VALUES ('704', '9', '4'); -- DEX+4

-- ----------------------------
-- Foul Waters
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('705', '2', '10'); -- HP+10
INSERT INTO `blue_spell_mods` VALUES ('705', '10', '4'); -- VIT+4

-- ----------------------------
-- Glutinous Dart
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('706', '2', '15'); -- HP+15
INSERT INTO `blue_spell_mods` VALUES ('706', '8', '3'); -- STR+3
INSERT INTO `blue_spell_mods` VALUES ('706', '9', '3'); -- DEX+3
INSERT INTO `blue_spell_mods` VALUES ('706', '12', '-3'); -- INT-3

-- ----------------------------
-- Retinal Glare
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('707', '5', '15'); -- MP+15
INSERT INTO `blue_spell_mods` VALUES ('707', '12', '3'); -- INT+3

-- ----------------------------
-- Subduction
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('708', '0', '0'); --

-- ----------------------------
--  Thrashing Assault
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('709', '0', '0'); --

-- ----------------------------
-- Erratic Flutter
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('710', '0', '0'); --

-- ----------------------------
 -- Restoral
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('711', '0', '0'); --

-- ----------------------------
 -- Rail Cannon
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('712', '0', '0'); --

-- ----------------------------
 -- Diffusion Ray
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('713', '0', '0'); --

-- ----------------------------
 -- Sinker Drill
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('714', '0', '0'); --

-- ----------------------------
-- Thunderbolt
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('736', '0', '0'); --

-- ----------------------------
-- Harden Shell
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('737', '0', '0'); --

-- ----------------------------
-- Absolute Terror
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('738', '0', '0'); --

-- ----------------------------
-- Gates of Hades
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('739', '0', '0'); --

-- ----------------------------
-- Tourbillion
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('740', '0', '0'); --

-- ----------------------------
-- Pyric Bulwark
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('741', '0', '0'); --

-- ----------------------------
-- Bilgestorm
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('742', '0', '0'); --

-- ----------------------------
-- Bloodrake
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('743', '0', '0'); --

-- ----------------------------
-- Droning Whirlwind
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('744', '0', '0'); --

-- ----------------------------
-- Carcharian Verve
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('745', '0', '0'); --

-- ----------------------------
-- Blistering Roar
-- ----------------------------
INSERT INTO `blue_spell_mods` VALUES ('746', '0', '0'); --
