------------------------------------
-- Rhapsodies of Vana'diel Job SQL Adjustments
-- This module reverts relevant SQL tables for jobs to their pre-RoV values
------------------------------------

------------------------------------
-- Monk
-- Source: https://forum.square-enix.com/ffxi/threads/52969
------------------------------------

-- Boost: Revert recast from 60 to 15 seconds
UPDATE abilities SET recastTime = 15 WHERE name = 'boost';

-- Focus: Revert recast from 2 to 5 minutes
UPDATE abilities SET recastTime = 300 WHERE name = 'focus';

-- Dodge: Revert recast from 2 to 5 minutes
UPDATE abilities SET recastTime = 300 WHERE name = 'dodge';

-- Chakra: Revert recast from 3 to 5 minutes
UPDATE abilities SET recastTime = 300 WHERE name = 'chakra';

-- Max HP Boost: Revert trait levels to 35/55/70
UPDATE traits SET level = 35 WHERE name = 'max hp boost' AND job = 2 AND rank = 2;
UPDATE traits SET level = 55 WHERE name = 'max hp boost' AND job = 2 AND rank = 3;
UPDATE traits SET level = 70 WHERE name = 'max hp boost' AND job = 2 AND rank = 4;

------------------------------------
-- Paladin
------------------------------------

-- Rampart: Revert recast from 3 to 5 minutes
-- Source: https://forum.square-enix.com/ffxi/threads/56444-February-12-2020-%28JST%29-Version-Update
UPDATE abilities SET recastTime = 300 WHERE name = 'rampart';

------------------------------------
-- Ranger
------------------------------------

-- Velocity Shot: Revert recast from 1 minute to 5 minutes
-- Source: https://forum.square-enix.com/ffxi/threads/55263-April.-3-2019-%28JST%29-Version-Update
UPDATE abilities SET recastTime = 300 WHERE name = 'velocity_shot';

-- Archery and Marksmanship: Revert skill rank increase from A+ to A.
-- Source: https://forum.square-enix.com/ffxi/threads/47481-Jun-25-2015-%28JST%29-Version-Update
UPDATE skill_ranks SET rng = 2 WHERE name = 'archery';
UPDATE skill_ranks SET rng = 2 WHERE name = 'marksmanship';

------------------------------------
-- Dragoon
-- Source: https://forum.square-enix.com/ffxi/threads/54901-January.-10-2019-%28JST%29-Version-Update
------------------------------------

-- Jump / Spirit Jump: Revert to share a cooldown
UPDATE abilities SET recastId = 158 WHERE name = 'jump';
UPDATE abilities SET recastId = 158 WHERE name = 'spirit_jump';

-- High Jump / Soul Jump: Revert to share a cooldown
UPDATE abilities SET recastId = 159 WHERE name = 'high_jump';
UPDATE abilities SET recastId = 159 WHERE name = 'soul_jump';

------------------------------------
-- Summoner
------------------------------------

-- Bloodpact: Ward AoE skills: Revert radius from 14 to 10
-- TODO: Could use more verification on exact range value
-- Source: https://forum.square-enix.com/ffxi/threads/46531-Mar-26-2015-%28JST%29-Version-Update
UPDATE pet_skills SET pet_skill_radius = 10 WHERE pet_skill_name IN (
    'shining_ruby',
    'glittering_ruby',
    'healing_ruby_ii',
    'soothing_ruby',
    'ecliptic_growl',
    'ecliptic_howl',
    'heavenward_howl',
    'crimson_howl',
    'inferno_howl',
    'earthen_ward',
    'spring_water',
    'soothing_current',
    'whispering_wind',
    'hastega',
    'aerial_armor',
    'fleet_wind',
    'hastega_ii',
    'frost_armor',
    'crystal_blessing',
    'rolling_thunder',
    'lightning_armor',
    'noctoshield',
    'dream_shroud'
);

-- Avatar Bloodpact Prepare Times
-- https://wiki.ffo.jp/html/32936.html

-- Carbuncle
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'healing_ruby';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'poison_nails';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'shining_ruby';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'glittering_ruby';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'meteorite';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'healing_ruby_ii';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'searing_light';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'soothing_ruby';

-- Fenrir
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'moonlit_charge';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'crescent_fang';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'lunar_cry';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'lunar_roar';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'ecliptic_growl';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'ecliptic_howl';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'eclipse_bite';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'howling_moon';

-- Ifrit
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'punch';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'fire_ii';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'burning_strike';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'double_punch';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'crimson_howl';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'fire_iv';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'flaming_crush';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'meteor_strike';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'inferno';

-- Titan
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'rock_throw';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'stone_ii';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'rock_buster';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'megalith_throw';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'earthen_ward';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'stone_iv';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'mountain_buster';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'geocrush';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'earthen_fury';

-- Leviathan
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'barracuda_dive';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'water_ii';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'tail_whip';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'spring_water';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'slowga';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'water_iv';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'spinning_dive';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'grand_fall';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'tidal_wave';

-- Garuda
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'claw';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'aero_ii';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'whispering_wind';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'hastega';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'aerial_armor';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'aero_iv';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'predator_claws';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'wind_blade';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'aerial_blast';

-- Shiva
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'axe_kick';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'blizzard_ii';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'frost_armor';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'sleepga';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'double_slap';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'blizzard_iv';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'rush';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'heavenly_strike';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'diamond_dust';

-- Ramuh
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'shock_strike';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'thunder_ii';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'rolling_thunder';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'thunderspark';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'lightning_armor';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'thunder_iv';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'chaotic_strike';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'thunderstorm';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'judgment_bolt';

-- Diabolos
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'camisado';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'somnolence';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'nightmare';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'ultimate_terror';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'noctoshield';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'dream_shroud';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'nether_blast';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'ruinous_omen';

-- Jug Pet Skills
-- Reverts jug skill prepare/animation time.
-- Implemented January 10th, 2020
-- https://wiki.ffo.jp/html/38465.html
UPDATE pet_skills SET pet_anim_time = 2033, pet_prepare_time =  200 WHERE pet_skill_name = 'foot_kick';
UPDATE pet_skills SET pet_anim_time = 3216, pet_prepare_time =  200 WHERE pet_skill_name = 'dust_cloud';
UPDATE pet_skills SET pet_anim_time = 1350, pet_prepare_time =  200 WHERE pet_skill_name = 'whirl_claws';
UPDATE pet_skills SET pet_anim_time = 1500, pet_prepare_time =  800 WHERE pet_skill_name = 'head_butt';
UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 1200 WHERE pet_skill_name = 'dream_flower';
UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time =  800 WHERE pet_skill_name = 'wild_oats';
UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 1200 WHERE pet_skill_name = 'leaf_dagger';
UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time =  800 WHERE pet_skill_name = 'scream';
UPDATE pet_skills SET pet_anim_time = 2666, pet_prepare_time = 1000 WHERE pet_skill_name = 'roar';
UPDATE pet_skills SET pet_anim_time = 2900, pet_prepare_time = 1000 WHERE pet_skill_name = 'razor_fang';
UPDATE pet_skills SET pet_anim_time = 3316, pet_prepare_time = 1000 WHERE pet_skill_name = 'claw_cyclone';
UPDATE pet_skills SET pet_anim_time = 2183, pet_prepare_time = 1000 WHERE pet_skill_name = 'tail_blow';
UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 1000 WHERE pet_skill_name = 'fireball';
UPDATE pet_skills SET pet_anim_time = 1633, pet_prepare_time = 1000 WHERE pet_skill_name = 'blockhead';
UPDATE pet_skills SET pet_anim_time = 1633, pet_prepare_time = 1000 WHERE pet_skill_name = 'brain_crush';
UPDATE pet_skills SET pet_anim_time = 2866, pet_prepare_time = 1000 WHERE pet_skill_name = 'infrasonics';
UPDATE pet_skills SET pet_anim_time = 2666, pet_prepare_time = 1000 WHERE pet_skill_name = 'secretion';
UPDATE pet_skills SET pet_anim_time = 3000, pet_prepare_time =  500 WHERE pet_skill_name = 'lamb_chop';
UPDATE pet_skills SET pet_anim_time = 3500, pet_prepare_time =  200 WHERE pet_skill_name = 'rage';
UPDATE pet_skills SET pet_anim_time = 3000, pet_prepare_time =  500 WHERE pet_skill_name = 'sheep_charge';
UPDATE pet_skills SET pet_anim_time = 3000, pet_prepare_time = 1000 WHERE pet_skill_name = 'sheep_song';
UPDATE pet_skills SET pet_anim_time = 2333, pet_prepare_time = 2000 WHERE pet_skill_name = 'bubble_shower';
UPDATE pet_skills SET pet_anim_time = 2333, pet_prepare_time = 1000 WHERE pet_skill_name = 'bubble_curtain';
UPDATE pet_skills SET pet_anim_time = 2483, pet_prepare_time = 1000 WHERE pet_skill_name = 'big_scissors';
UPDATE pet_skills SET pet_anim_time = 1700, pet_prepare_time = 1000 WHERE pet_skill_name = 'scissor_guard';
UPDATE pet_skills SET pet_anim_time = 1950, pet_prepare_time = 1000 WHERE pet_skill_name = 'metallic_body';
UPDATE pet_skills SET pet_anim_time = 1750, pet_prepare_time = 1000 WHERE pet_skill_name = 'needleshot';
UPDATE pet_skills SET pet_anim_time = 3283, pet_prepare_time = 2000 WHERE pet_skill_name = 'random_needles';
UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 1500 WHERE pet_skill_name = 'frogkick';
UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 1500 WHERE pet_skill_name = 'spore';
UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 1500 WHERE pet_skill_name = 'queasyshroom';
UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 1500 WHERE pet_skill_name = 'numbshroom';
UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 1500 WHERE pet_skill_name = 'shakeshroom';
UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 1500 WHERE pet_skill_name = 'silence_gas';
UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 1500 WHERE pet_skill_name = 'dark_spore';
UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 1000 WHERE pet_skill_name = 'power_attack_beetle';
UPDATE pet_skills SET pet_anim_time = 1700, pet_prepare_time = 1000 WHERE pet_skill_name = 'hi-freq_field';
UPDATE pet_skills SET pet_anim_time = 1800, pet_prepare_time = 1000 WHERE pet_skill_name = 'rhino_attack';
UPDATE pet_skills SET pet_anim_time = 2700, pet_prepare_time = 1000 WHERE pet_skill_name = 'rhino_guard';
UPDATE pet_skills SET pet_anim_time = 1900, pet_prepare_time = 1000 WHERE pet_skill_name = 'spoil';
UPDATE pet_skills SET pet_anim_time = 2750, pet_prepare_time = 1000 WHERE pet_skill_name = 'cursed_sphere';
UPDATE pet_skills SET pet_anim_time = 3016, pet_prepare_time = 1000 WHERE pet_skill_name = 'venom';
UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 1000 WHERE pet_skill_name = 'sandblast';
UPDATE pet_skills SET pet_anim_time = 1600, pet_prepare_time = 1000 WHERE pet_skill_name = 'sandpit';
UPDATE pet_skills SET pet_anim_time = 1683, pet_prepare_time = 1000 WHERE pet_skill_name = 'venom_spray';
UPDATE pet_skills SET pet_anim_time = 2133, pet_prepare_time = 1000 WHERE pet_skill_name = 'mandibular_bite';
UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 1500 WHERE pet_skill_name = 'soporific';
UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 1500 WHERE pet_skill_name = 'gloeosuccus';
UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 1500 WHERE pet_skill_name = 'palsy_pollen';
UPDATE pet_skills SET pet_anim_time = 2400, pet_prepare_time = 1000 WHERE pet_skill_name = 'geist_wall';
UPDATE pet_skills SET pet_anim_time = 1533, pet_prepare_time = 1000 WHERE pet_skill_name = 'numbing_noise';
UPDATE pet_skills SET pet_anim_time = 1800, pet_prepare_time = 1000 WHERE pet_skill_name = 'nimble_snap';
UPDATE pet_skills SET pet_anim_time = 2133, pet_prepare_time = 1000 WHERE pet_skill_name = 'cyclotail';
UPDATE pet_skills SET pet_anim_time = 1750, pet_prepare_time = 1000 WHERE pet_skill_name = 'toxic_spit';
UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time =  800 WHERE pet_skill_name = 'double_claw';
UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 1500 WHERE pet_skill_name = 'grapple';
UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 1500 WHERE pet_skill_name = 'filamented_hold';
UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time =  800 WHERE pet_skill_name = 'spinning_top';
UPDATE pet_skills SET pet_anim_time = 2133, pet_prepare_time = 1000 WHERE pet_skill_name = 'chaotic_eye';
UPDATE pet_skills SET pet_anim_time = 2400, pet_prepare_time = 1000 WHERE pet_skill_name = 'blaster';
UPDATE pet_skills SET pet_anim_time = 2733, pet_prepare_time = 1000 WHERE pet_skill_name = 'suction';
UPDATE pet_skills SET pet_anim_time = 2166, pet_prepare_time = 1000 WHERE pet_skill_name = 'drainkiss';
UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time =  200 WHERE pet_skill_name = 'snow_cloud';
UPDATE pet_skills SET pet_anim_time = 5000, pet_prepare_time = 3000 WHERE pet_skill_name = 'wild_carrot';
UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 1800 WHERE pet_skill_name = 'sudden_lunge';
UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 1000 WHERE pet_skill_name = 'spiral_spin';
UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 1000 WHERE pet_skill_name = 'noisome_powder';
UPDATE pet_skills SET pet_anim_time = 3166, pet_prepare_time = 1000 WHERE pet_skill_name = 'acid_mist';
UPDATE pet_skills SET pet_anim_time = 2616, pet_prepare_time = 1000 WHERE pet_skill_name = 'tp_drainkiss';
UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 1000 WHERE pet_skill_name = 'scythe_tail';
UPDATE pet_skills SET pet_anim_time = 2283, pet_prepare_time = 1000 WHERE pet_skill_name = 'ripper_fang';
UPDATE pet_skills SET pet_anim_time = 2400, pet_prepare_time = 1000 WHERE pet_skill_name = 'chomp_rush';
UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 2000 WHERE pet_skill_name = 'charged_whisker';
UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 1000 WHERE pet_skill_name = 'purulent_ooze';
UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 1000 WHERE pet_skill_name = 'corrosive_ooze';
UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 1500 WHERE pet_skill_name = 'back_heel';
UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 1500 WHERE pet_skill_name = 'jettatura';
UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 1500 WHERE pet_skill_name = 'choke_breath';
UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 1500 WHERE pet_skill_name = 'fantod';
UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 1500 WHERE pet_skill_name = 'tortoise_stomp';
UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 1500 WHERE pet_skill_name = 'harden_shell';
UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 1500 WHERE pet_skill_name = 'aqua_breath';
UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 1500 WHERE pet_skill_name = 'wing_slap';
UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 1500 WHERE pet_skill_name = 'beak_lunge';
UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 1000 WHERE pet_skill_name = 'intimidate';
UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 1500 WHERE pet_skill_name = 'recoil_dive';
UPDATE pet_skills SET pet_anim_time = 2116, pet_prepare_time = 1000 WHERE pet_skill_name = 'water_wall';
-- UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 2000 WHERE pet_skill_name = 'sensilla_blades';
-- UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 2000 WHERE pet_skill_name = 'tegmina_buffet';
-- UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 2000 WHERE pet_skill_name = 'molting_plumage';
-- UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 2000 WHERE pet_skill_name = 'swooping_frenzy';
-- UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 2000 WHERE pet_skill_name = 'sweeping_gouge';
-- UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 2000 WHERE pet_skill_name = 'zealous_snort';
-- UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 2000 WHERE pet_skill_name = 'pentapeck';
-- UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 2000 WHERE pet_skill_name = 'tickling_tendrils';
-- UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 2000 WHERE pet_skill_name = 'stink_bomb';
-- UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 2000 WHERE pet_skill_name = 'nectarous_deluge';
-- UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 2000 WHERE pet_skill_name = 'nepenthic_plunge';
UPDATE pet_skills SET pet_anim_time = 2466, pet_prepare_time = 1000 WHERE pet_skill_name = 'somersault';
-- UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 2000 WHERE pet_skill_name = 'foul_waters';
-- UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 2000 WHERE pet_skill_name = 'pestilent_plume';
UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 1500 WHERE pet_skill_name = 'pecking_flurry';
UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 1500 WHERE pet_skill_name = 'sickle_slash';
UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 1500 WHERE pet_skill_name = 'acid_spray';
UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 1500 WHERE pet_skill_name = 'spider_web';
-- UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 2000 WHERE pet_skill_name = 'infected_leech';
-- UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 2000 WHERE pet_skill_name = 'gloom_spray';
-- UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 2000 WHERE pet_skill_name = 'disembowel';
-- UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 2000 WHERE pet_skill_name = 'extirpating_salvo';
-- UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 2000 WHERE pet_skill_name = 'venom_shower';
-- UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 2000 WHERE pet_skill_name = 'mega_scissors';
-- UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 2000 WHERE pet_skill_name = 'frenzied_rage';
-- UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 2000 WHERE pet_skill_name = 'rhinowrecker';
UPDATE pet_skills SET pet_anim_time = 1833, pet_prepare_time = 1000 WHERE pet_skill_name = 'fluid_toss';
UPDATE pet_skills SET pet_anim_time = 2500, pet_prepare_time = 1000 WHERE pet_skill_name = 'fluid_spread';
UPDATE pet_skills SET pet_anim_time = 4166, pet_prepare_time = 1000 WHERE pet_skill_name = 'digest';
UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 1500 WHERE pet_skill_name = 'crossthrash';
UPDATE pet_skills SET pet_anim_time = 3300, pet_prepare_time = 1000 WHERE pet_skill_name = 'predatory_glare';
UPDATE pet_skills SET pet_anim_time = 3000, pet_prepare_time = 1500 WHERE pet_skill_name = 'hoof_volley';
UPDATE pet_skills SET pet_anim_time = 2000, pet_prepare_time = 1500 WHERE pet_skill_name = 'nihility_song';
