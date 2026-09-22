-----------------------------------
--   Dynamis 75 Era Module       --
-----------------------------------
-----------------------------------
--   Module Required Scripts     --
-----------------------------------
require('scripts/globals/dynamis')
require('scripts/globals/dynamis/settings_era')
require('scripts/globals/dynamis/zone_config')
require('scripts/globals/dynamis/respawn_tables')
require('scripts/globals/dynamis/participants')
require('scripts/globals/dynamis/dyna_lockout')
require('scripts/globals/dynamis/entry_era')
require('scripts/globals/dynamis/ejection')
require('scripts/globals/dynamis/hourglass')
require('scripts/globals/dynamis/npc_handlers')
require('scripts/globals/dynamis/dynamis_system')
require('scripts/globals/dynamis/mobs/dynamis_mobs_sandy')
require('scripts/globals/dynamis/mobs/dynamis_mobs_bastok')
require('scripts/globals/dynamis/mobs/dynamis_mobs_windurst')
require('scripts/globals/dynamis/mobs/dynamis_mobs_jeuno')
require('scripts/globals/dynamis/mobs/dynamis_mobs_beaucedine')
require('scripts/globals/dynamis/mobs/dynamis_mobs_xarcabard')
require('scripts/globals/dynamis/mobs/dynamis_mobs_valk')
require('scripts/globals/dynamis/mobs/dynamis_mobs_buburimu')
require('scripts/globals/dynamis/mobs/dynamis_mobs_qufim')
require('scripts/globals/dynamis/mobs/dynamis_mobs_tav')
require('scripts/globals/dynamis/dynamis_mobinfo')
require('scripts/globals/dynamis/zonemechs/buburimu')
require('scripts/globals/dynamis/zonemechs/valkurm')
require('scripts/globals/dynamis/zonemechs/tavnazia')
require('modules/module_utils')
-----------------------------------
--    Module Affected Scripts    --
-----------------------------------
local m = Module:new('dynamis_zones')

local dynamisZones =
{
    { xi.zone.DYNAMIS_SAN_DORIA,  'Dynamis-San_dOria',  1  },
    { xi.zone.DYNAMIS_BASTOK,     'Dynamis-Bastok',     2  },
    { xi.zone.DYNAMIS_WINDURST,   'Dynamis-Windurst',   3  },
    { xi.zone.DYNAMIS_JEUNO,      'Dynamis-Jeuno',      4  },
    { xi.zone.DYNAMIS_BEAUCEDINE, 'Dynamis-Beaucedine', 5  },
    { xi.zone.DYNAMIS_XARCABARD,  'Dynamis-Xarcabard',  6  },
    { xi.zone.DYNAMIS_VALKURM,    'Dynamis-Valkurm',    7  },
    { xi.zone.DYNAMIS_BUBURIMU,   'Dynamis-Buburimu',   8  },
    { xi.zone.DYNAMIS_QUFIM,      'Dynamis-Qufim',      9  },
    { xi.zone.DYNAMIS_TAVNAZIA,   'Dynamis-Tavnazia',   10 },
}

local startingZones =
{
    { 'Southern_San_dOria',   'Trail_Markings' },
    { 'Bastok_Mines',         'Trail_Markings' },
    { 'Windurst_Walls',       'Trail_Markings' },
    { 'RuLude_Gardens',       'Trail_Markings' },
    { 'Beaucedine_Glacier',   'Trail_Markings' },
    { 'Xarcabard',            'Trail_Markings' },
    { 'Valkurm_Dunes',        'Hieroglyphics'  },
    { 'Buburimu_Peninsula',   'Hieroglyphics'  },
    { 'Qufim_Island',         'Hieroglyphics'  },
    { 'Tavnazian_Safehold',   'Hieroglyphics'  },
}

local mobType = xi.dynamis.mobType

local mobNames =
{
    -- 'name', mobtype, modelsize
    ['Dynamis-San_dOria'] =
    {
        { 'Overlords_Tombstone',     mobType.BOSS  , 3 },
        { 'Serjeant_Tombstone',      mobType.STATUE, 1 },
        { 'Warchief_Tombstone',      mobType.STATUE, 1 },
        { 'Battlechoir_Gitchfotch',  mobType.NORMAL, 3 },
        { 'Reapertongue_Gadgquok',   mobType.MASTER, 3 },
        { 'Soulsender_Fugbrag',      mobType.NORMAL, 3 },
        { 'Voidstreaker_Butchnotch', mobType.NORMAL, 3 },
        { 'Wyrmgnasher_Bjakdek',     mobType.MASTER, 3 },
        { 'Vanguard_Amputator',      mobType.NORMAL, 2 },
        { 'Vanguard_Backstabber',    mobType.NORMAL, 2 },
        { 'Vanguard_Bugler',         mobType.NORMAL, 2 },
        { 'Vanguard_Dollmaster',     mobType.MASTER, 2 },
        { 'Vanguard_Footsoldier',    mobType.NORMAL, 2 },
        { 'Vanguard_Grappler',       mobType.NORMAL, 2 },
        { 'Vanguard_Gutslasher',     mobType.NORMAL, 2 },
        { 'Vanguard_Hawker',         mobType.MASTER, 2 },
        { 'Vanguard_Impaler',        mobType.MASTER, 2 },
        { 'Vanguard_Mesmerizer',     mobType.NORMAL, 2 },
        { 'Vanguard_Neckchopper',    mobType.NORMAL, 2 },
        { 'Vanguard_Pillager',       mobType.NORMAL, 2 },
        { 'Vanguard_Predator',       mobType.NORMAL, 2 },
        { 'Vanguard_Trooper',        mobType.NORMAL, 2 },
        { 'Vanguard_Vexer',          mobType.NORMAL, 2 },
        { 'Vanguards_Hecteyes',      mobType.NORMAL, 1 },
        { 'Vanguards_Wyvern',        mobType.NORMAL, 2 },
        { 'Vanguards_Avatar', mobType.AVATAR, 2 },
    },
    ['Dynamis-Bastok'] =
    {
        { 'GuDha_Effigy',         mobType.BOSS  , 3 },
        { 'Adamantking_Effigy',   mobType.STATUE, 1 },
        { 'AaNyu_Dismantler',     mobType.NORMAL, 3 },
        { 'BeEbo_Tortoisedriver', mobType.MASTER, 3 },
        { 'Effigy_Shield',        mobType.NORMAL, 3 },
        { 'GiPha_Manameister',    mobType.NORMAL, 3 },
        { 'GuNhi_Noondozer',      mobType.MASTER, 3 },
        { 'KoDho_Cannonball',     mobType.NORMAL, 3 },
        { 'ZeVho_Fallsplitter',   mobType.NORMAL, 3 },
        { 'Vanguard_Beasttender', mobType.MASTER, 2 },
        { 'Vanguard_Constable',   mobType.NORMAL, 2 },
        { 'Vanguard_Defender',    mobType.NORMAL, 2 },
        { 'Vanguard_Drakekeeper', mobType.MASTER, 2 },
        { 'Vanguard_Hatamoto',    mobType.NORMAL, 2 },
        { 'Vanguard_Kusa',        mobType.NORMAL, 2 },
        { 'Vanguard_Mason',       mobType.NORMAL, 2 },
        { 'Vanguard_Militant',    mobType.NORMAL, 2 },
        { 'Vanguard_Minstrel',    mobType.NORMAL, 2 },
        { 'Vanguard_Protector',   mobType.NORMAL, 2 },
        { 'Vanguard_Purloiner',   mobType.NORMAL, 2 },
        { 'Vanguard_Thaumaturge', mobType.NORMAL, 2 },
        { 'Vanguard_Undertaker',  mobType.MASTER, 2 },
        { 'Vanguard_Vigilante',   mobType.NORMAL, 2 },
        { 'Vanguard_Vindicator',  mobType.NORMAL, 2 },
        { 'Vanguards_Scorpion',   mobType.NORMAL, 2 },
        { 'Vanguards_Wyvern',     mobType.NORMAL, 2 },
        { 'Vanguards_Avatar', mobType.AVATAR, 2 },
    },
    ['Dynamis-Windurst'] =
    {
        { 'Tzee_Xicu_Idol',          mobType.BOSS  , 3 },
        { 'Avatar_Icon',             mobType.STATUE, 1 },
        { 'Avatar_Idol',             mobType.STATUE, 1 },
        { 'Manifest_Icon',           mobType.STATUE, 1 },
        { 'Haa_Pevi_the_Stentorian', mobType.MASTER, 3 },
        { 'Loo_Hepe_the_Eyepiercer', mobType.NORMAL, 3 },
        { 'Maa_Febi_the_Steadfast',  mobType.NORMAL, 3 },
        { 'Muu_Febi_the_Steadfast',  mobType.NORMAL, 3 },
        { 'Wuu_Qoho_the_Razorclaw',  mobType.NORMAL, 3 },
        { 'Xoo_Kaza_the_Solemn',     mobType.NORMAL, 3 },
        { 'Vanguard_Assassin',       mobType.NORMAL, 2 },
        { 'Vanguard_Chanter',        mobType.NORMAL, 2 },
        { 'Vanguard_Exemplar',       mobType.NORMAL, 2 },
        { 'Vanguard_Inciter',        mobType.NORMAL, 2 },
        { 'Vanguard_Liberator',      mobType.NORMAL, 2 },
        { 'Vanguard_Ogresoother',    mobType.MASTER, 2 },
        { 'Vanguard_Oracle',         mobType.MASTER, 2 },
        { 'Vanguard_Partisan',       mobType.MASTER, 2 },
        { 'Vanguard_Persecutor',     mobType.NORMAL, 2 },
        { 'Vanguard_Prelate',        mobType.NORMAL, 2 },
        { 'Vanguard_Priest',         mobType.NORMAL, 2 },
        { 'Vanguard_Salvager',       mobType.NORMAL, 2 },
        { 'Vanguard_Sentinel',       mobType.NORMAL, 2 },
        { 'Vanguard_Skirmisher',     mobType.NORMAL, 2 },
        { 'Vanguard_Visionary',      mobType.NORMAL, 2 },
        { 'Vanguards_Crow',          mobType.NORMAL, 2 },
        { 'Vanguards_Wyvern',        mobType.NORMAL, 2 },
        { 'Vanguards_Avatar', mobType.AVATAR, 2 },
    },
    ['Dynamis-Jeuno'] =
    {
        { 'Goblin_Golem',           mobType.BOSS  , 3 },
        { 'Goblin_Replica',         mobType.STATUE, 2 },
        { 'Goblin_Statue',          mobType.STATUE, 2 },
        { 'Anvilix_Sootwrists',     mobType.NORMAL, 3 },
        { 'Bandrix_Rockjaw',        mobType.NORMAL, 3 },
        { 'Blazox_Boneybod',        mobType.MASTER, 3 },
        { 'Bootrix_Jaggedelbow',    mobType.NORMAL, 3 },
        { 'Buffrix_Eargone',        mobType.NORMAL, 3 },
        { 'Cloktix_Longnail',       mobType.NORMAL, 3 },
        { 'Distilix_Stickytoes',    mobType.NORMAL, 3 },
        { 'Elixmix_Hooknose',       mobType.NORMAL, 3 },
        { 'Eremix_Snottynostril',   mobType.NORMAL, 3 },
        { 'Gabblox_Magpietongue',   mobType.NORMAL, 3 },
        { 'Hermitrix_Toothrot',     mobType.NORMAL, 3 },
        { 'Humnox_Drumbelly',       mobType.NORMAL, 3 },
        { 'Jabbrox_Grannyguise',    mobType.NORMAL, 3 },
        { 'Jabkix_Pigeonpecs',      mobType.NORMAL, 3 },
        { 'Karashix_Swollenskull',  mobType.NORMAL, 3 },
        { 'Kikklix_Longlegs',       mobType.NORMAL, 3 },
        { 'Lurklox_Dhalmelneck',    mobType.NORMAL, 3 },
        { 'Mobpix_Mucousmouth',     mobType.NORMAL, 3 },
        { 'Morgmox_Moldnoggin',     mobType.MASTER, 3 },
        { 'Mortilox_Wartpaws',      mobType.MASTER, 3 },
        { 'Prowlox_Barrelbelly',    mobType.NORMAL, 3 },
        { 'Rutrix_Hamgams',         mobType.MASTER, 3 },
        { 'Scruffix_Shaggychest',   mobType.NORMAL, 3 },
        { 'Slystix_Megapeepers',    mobType.NORMAL, 3 },
        { 'Smeltix_Thickhide',      mobType.NORMAL, 3 },
        { 'Snypestix_Eaglebeak',    mobType.NORMAL, 3 },
        { 'Sparkspox_Sweatbrow',    mobType.NORMAL, 3 },
        { 'Ticktox_Beadyeyes',      mobType.NORMAL, 3 },
        { 'Trailblix_Goatmug',      mobType.MASTER, 3 },
        { 'Tufflix_Loglimbs',       mobType.NORMAL, 3 },
        { 'Tymexox_Ninefingers',    mobType.NORMAL, 3 },
        { 'Wasabix_Callusdigit',    mobType.NORMAL, 3 },
        { 'Wyrmwix_Snakespecs',     mobType.MASTER, 3 },
        { 'Vanguard_Alchemist',     mobType.NORMAL, 2 },
        { 'Vanguard_Ambusher',      mobType.NORMAL, 2 },
        { 'Vanguard_Armorer',       mobType.NORMAL, 2 },
        { 'Vanguard_Dragontamer',   mobType.MASTER, 2 },
        { 'Vanguard_Enchanter',     mobType.NORMAL, 2 },
        { 'Vanguard_Hitman',        mobType.NORMAL, 2 },
        { 'Vanguard_Maestro',       mobType.NORMAL, 2 },
        { 'Vanguard_Necromancer',   mobType.MASTER, 2 },
        { 'Vanguard_Pathfinder',    mobType.MASTER, 2 },
        { 'Vanguard_Pitfighter',    mobType.NORMAL, 2 },
        { 'Vanguard_Ronin',         mobType.NORMAL, 2 },
        { 'Vanguard_Shaman',        mobType.NORMAL, 2 },
        { 'Vanguard_Smithy',        mobType.NORMAL, 2 },
        { 'Vanguard_Tinkerer',      mobType.NORMAL, 2 },
        { 'Vanguard_Welldigger',    mobType.NORMAL, 2 },
        { 'Vanguards_Slime',        mobType.NORMAL, 2 },
        { 'Vanguards_Wyvern',       mobType.NORMAL, 2 },
        { 'Vanguards_Avatar', mobType.AVATAR, 2 },
    },
    ['Dynamis-Beaucedine'] =
    {
        { 'Angra_Mainyu',            mobType.BOSS  , 3 },
        { 'Adamantking_Effigy',      mobType.STATUE, 2 },
        { 'Avatar_Icon',             mobType.STATUE, 2 },
        { 'Goblin_Replica',          mobType.STATUE, 2 },
        { 'Dynamis_Effigy',          mobType.STATUE, 3 },
        { 'Dynamis_Icon',            mobType.STATUE, 3 },
        { 'Dynamis_Statue',          mobType.STATUE, 3 },
        { 'Dynamis_Tombstone',       mobType.STATUE, 3 },
        { 'Vanguard_Eye',            mobType.STATUE, 2 },
        { 'Serjeant_Tombstone',      mobType.STATUE, 2 },
        { 'Ascetox_Ratgums',         mobType.NORMAL, 3 },
        { 'BeZhe_Keeprazer',         mobType.MASTER, 3 },
        { 'Bhuu_Wjato_the_Firepool', mobType.NORMAL, 3 },
        { 'Bordox_Kittyback',        mobType.NORMAL, 3 },
        { 'Brewnix_Bittypupils',     mobType.NORMAL, 3 },
        { 'Caa_Xaza_the_Madpiercer', mobType.NORMAL, 3 },
        { 'Cobraclaw_Buchzvotch',    mobType.NORMAL, 3 },
        { 'Dagourmarche',            mobType.BOSS, 3 },
        { 'Dagourmarches_Avatar',    mobType.NORMAL, 2 },
        { 'Dagourmarches_Wyvern',    mobType.NORMAL, 2 },
        { 'Goublefaupe',             mobType.BOSS, 3 },
        { 'Mildaunegeux',            mobType.BOSS, 3 },
        { 'Quiebitiel',              mobType.BOSS, 3 },
        { 'Velosareon',              mobType.BOSS, 3 },
        { 'Deathcaller_Bidfbid',     mobType.MASTER, 3 },
        { 'DeBho_Pyrohand',          mobType.NORMAL, 3 },
        { 'Drakefeast_Wubmfub',      mobType.MASTER, 3 },
        { 'Draklix_Scalecrust',      mobType.MASTER, 3 },
        { 'Droprix_Granitepalms',    mobType.NORMAL, 3 },
        { 'Elvaanlopper_Grokdok',    mobType.NORMAL, 3 },
        { 'Foo_Peku_the_Bloodcloak', mobType.NORMAL, 3 },
        { 'GaFho_Venomtouch',        mobType.NORMAL, 3 },
        { 'Galkarider_Retzpratz',    mobType.NORMAL, 3 },
        { 'Gibberox_Pimplebeak',     mobType.NORMAL, 3 },
        { 'GoTyo_Magenapper',        mobType.MASTER, 3 },
        { 'GuKhu_Dukesniper',        mobType.NORMAL, 3 },
        { 'GuNha_Wallstormer',       mobType.NORMAL, 3 },
        { 'Guu_Waji_the_Preacher',   mobType.NORMAL, 3 },
        { 'Heavymail_Djidzbad',      mobType.NORMAL, 3 },
        { 'Hee_Mida_the_Meticulous', mobType.NORMAL, 3 },
        { 'Humegutter_Adzjbadj',     mobType.NORMAL, 3 },
        { 'Jeunoraider_Gepkzip',     mobType.NORMAL, 3 },
        { 'JiFhu_Infiltrator',       mobType.NORMAL, 3 },
        { 'JiKhu_Towercleaver',      mobType.NORMAL, 3 },
        { 'Knii_Hoqo_the_Bisector',  mobType.NORMAL, 3 },
        { 'Koo_Saxu_the_Everfast',   mobType.NORMAL, 3 },
        { 'Kuu_Xuka_the_Nimble',     mobType.NORMAL, 3 },
        { 'Lockbuster_Zapdjipp',     mobType.NORMAL, 3 },
        { 'Maa_Zaua_the_Wyrmkeeper', mobType.MASTER, 3 },
        { 'MiRhe_Whisperblade',      mobType.NORMAL, 3 },
        { 'Mithraslaver_Debhabob',   mobType.MASTER, 3 },
        { 'Moltenox_Stubthumbs',     mobType.NORMAL, 3 },
        { 'Morblox_Chubbychin',      mobType.MASTER, 3 },
        { 'MuGha_Legionkiller',      mobType.NORMAL, 3 },
        { 'NaHya_Floodmaker',        mobType.NORMAL, 3 },
        { 'Nee_Huxa_the_Judgmental', mobType.NORMAL, 3 },
        { 'NuBhi_Spiraleye',         mobType.NORMAL, 3 },
        { 'Puu_Timu_the_Phantasmal', mobType.MASTER, 3 },
        { 'Routsix_Rubbertendon',    mobType.MASTER, 3 },
        { 'Ruffbix_Jumbolobes',      mobType.NORMAL, 3 },
        { 'Ryy_Qihi_the_Idolrobber', mobType.NORMAL, 3 },
        { 'Shisox_Widebrow',         mobType.NORMAL, 3 },
        { 'Skinmask_Ugghfogg',       mobType.NORMAL, 3 },
        { 'Slinkix_Trufflesniff',    mobType.NORMAL, 3 },
        { 'SoGho_Adderhandler',      mobType.MASTER, 3 },
        { 'Soo_Jopo_the_Fiendking',  mobType.MASTER, 3 },
        { 'SoZho_Metalbender',       mobType.NORMAL, 3 },
        { 'Spinalsucker_Galflmall',  mobType.NORMAL, 3 },
        { 'Swypestix_Tigershins',    mobType.NORMAL, 3 },
        { 'TaHyu_Gallanthunter',     mobType.NORMAL, 3 },
        { 'Taruroaster_Biggsjig',    mobType.NORMAL, 3 },
        { 'Tocktix_Thinlids',        mobType.NORMAL, 3 },
        { 'Ultrasonic_Zeknajak',     mobType.NORMAL, 3 },
        { 'Whistrix_Toadthroat',     mobType.NORMAL, 3 },
        { 'Wraithdancer_Gidbnod',    mobType.NORMAL, 3 },
        { 'Xaa_Chau_the_Roctalon',   mobType.NORMAL, 3 },
        { 'Xhoo_Fuza_the_Sublime',   mobType.NORMAL, 3 },
        { 'Fire_Pukis',              mobType.NORMAL, 3 },
        { 'Petro_Pukis',             mobType.NORMAL, 3 },
        { 'Poison_Pukis',            mobType.NORMAL, 3 },
        { 'Wind_Pukis',              mobType.NORMAL, 3 },
        { 'Hydra_Bard',              mobType.NORMAL, 2 },
        { 'Hydra_Beastmaster',       mobType.MASTER, 2 },
        { 'Hydra_Black_Mage',        mobType.NORMAL, 2 },
        { 'Hydra_Dark_Knight',       mobType.NORMAL, 2 },
        { 'Hydra_Dragoon',           mobType.MASTER, 2 },
        { 'Hydra_Monk',              mobType.NORMAL, 2 },
        { 'Hydra_Ninja',             mobType.NORMAL, 2 },
        { 'Hydra_Paladin',           mobType.NORMAL, 2 },
        { 'Hydra_Ranger',            mobType.NORMAL, 2 },
        { 'Hydra_Red_Mage',          mobType.NORMAL, 2 },
        { 'Hydra_Samurai',           mobType.NORMAL, 2 },
        { 'Hydra_Summoner',          mobType.MASTER, 2 },
        { 'Hydra_Thief',             mobType.NORMAL, 2 },
        { 'Hydra_Warrior',           mobType.NORMAL, 2 },
        { 'Hydra_White_Mage',        mobType.NORMAL, 2 },
        { 'Hydras_Hound',            mobType.NORMAL, 2 },
        { 'Hydras_Wyvern',           mobType.NORMAL, 2 },
        { 'Vanguard_Alchemist',      mobType.NORMAL, 2 },
        { 'Vanguard_Ambusher',       mobType.NORMAL, 2 },
        { 'Vanguard_Amputator',      mobType.NORMAL, 2 },
        { 'Vanguard_Armorer',        mobType.NORMAL, 2 },
        { 'Vanguard_Assassin',       mobType.NORMAL, 2 },
        { 'Vanguard_Backstabber',    mobType.NORMAL, 2 },
        { 'Vanguard_Beasttender',    mobType.MASTER, 2 },
        { 'Vanguard_Bugler',         mobType.NORMAL, 2 },
        { 'Vanguard_Chanter',        mobType.NORMAL, 2 },
        { 'Vanguard_Constable',      mobType.NORMAL, 2 },
        { 'Vanguard_Defender',       mobType.NORMAL, 2 },
        { 'Vanguard_Dollmaster',     mobType.MASTER, 2 },
        { 'Vanguard_Dragontamer',    mobType.MASTER, 2 },
        { 'Vanguard_Drakekeeper',    mobType.MASTER, 2 },
        { 'Vanguard_Enchanter',      mobType.NORMAL, 2 },
        { 'Vanguard_Exemplar',       mobType.NORMAL, 2 },
        { 'Vanguard_Footsoldier',    mobType.NORMAL, 2 },
        { 'Vanguard_Grappler',       mobType.NORMAL, 2 },
        { 'Vanguard_Gutslasher',     mobType.NORMAL, 2 },
        { 'Vanguard_Hatamoto',       mobType.NORMAL, 2 },
        { 'Vanguard_Hawker',         mobType.MASTER, 2 },
        { 'Vanguard_Hitman',         mobType.NORMAL, 2 },
        { 'Vanguard_Impaler',        mobType.MASTER, 2 },
        { 'Vanguard_Inciter',        mobType.NORMAL, 2 },
        { 'Vanguard_Kusa',           mobType.NORMAL, 2 },
        { 'Vanguard_Liberator',      mobType.NORMAL, 2 },
        { 'Vanguard_Maestro',        mobType.NORMAL, 2 },
        { 'Vanguard_Mason',          mobType.NORMAL, 2 },
        { 'Vanguard_Mesmerizer',     mobType.NORMAL, 2 },
        { 'Vanguard_Militant',       mobType.NORMAL, 2 },
        { 'Vanguard_Minstrel',       mobType.NORMAL, 2 },
        { 'Vanguard_Neckchopper',    mobType.NORMAL, 2 },
        { 'Vanguard_Necromancer',    mobType.MASTER, 2 },
        { 'Vanguard_Ogresoother',    mobType.MASTER, 2 },
        { 'Vanguard_Oracle',         mobType.MASTER, 2 },
        { 'Vanguard_Partisan',       mobType.MASTER, 2 },
        { 'Vanguard_Pathfinder',     mobType.MASTER, 2 },
        { 'Vanguard_Persecutor',     mobType.NORMAL, 2 },
        { 'Vanguard_Pillager',       mobType.NORMAL, 2 },
        { 'Vanguard_Pitfighter',     mobType.NORMAL, 2 },
        { 'Vanguard_Predator',       mobType.NORMAL, 2 },
        { 'Vanguard_Prelate',        mobType.NORMAL, 2 },
        { 'Vanguard_Priest',         mobType.NORMAL, 2 },
        { 'Vanguard_Protector',      mobType.NORMAL, 2 },
        { 'Vanguard_Purloiner',      mobType.NORMAL, 2 },
        { 'Vanguard_Ronin',          mobType.NORMAL, 2 },
        { 'Vanguard_Salvager',       mobType.NORMAL, 2 },
        { 'Vanguard_Sentinel',       mobType.NORMAL, 2 },
        { 'Vanguard_Shaman',         mobType.NORMAL, 2 },
        { 'Vanguard_Skirmisher',     mobType.NORMAL, 2 },
        { 'Vanguard_Smithy',         mobType.NORMAL, 2 },
        { 'Vanguard_Thaumaturge',    mobType.NORMAL, 2 },
        { 'Vanguard_Tinkerer',       mobType.NORMAL, 2 },
        { 'Vanguard_Trooper',        mobType.NORMAL, 2 },
        { 'Vanguard_Undertaker',     mobType.MASTER, 2 },
        { 'Vanguard_Vexer',          mobType.NORMAL, 2 },
        { 'Vanguard_Vigilante',      mobType.NORMAL, 2 },
        { 'Vanguard_Vindicator',     mobType.NORMAL, 2 },
        { 'Vanguard_Visionary',      mobType.NORMAL, 2 },
        { 'Vanguard_Welldigger',     mobType.NORMAL, 2 },
        { 'Vanguards_Wyvern',        mobType.NORMAL, 2 },
        { 'Vanguards_Slime',         mobType.NORMAL, 2 },
        { 'Vanguards_Scorpion',      mobType.NORMAL, 2 },
        { 'Vanguards_Hecteyes',      mobType.NORMAL, 1 },
        { 'Vanguards_Crow',          mobType.NORMAL, 2 },
        { 'Vanguards_Avatar',        mobType.AVATAR, 2 },
        { 'Hydras_Avatar',           mobType.AVATAR, 2 },
    },
    ['Dynamis-Xarcabard'] =
    {
        { 'Dynamis_Lord',          mobType.BOSS  , 2 },
        { 'Effigy_Prototype',      mobType.STATUE, 2 },
        { 'Icon_Prototype',        mobType.STATUE, 2 },
        { 'Statue_Prototype',      mobType.STATUE, 2 },
        { 'Tombstone_Prototype',   mobType.STATUE, 2 },
        { 'Vanguard_Eye',          mobType.STATUE, 2 },
        { 'Animated_Claymore',     mobType.BOSS, 2 },
        { 'Animated_Dagger',       mobType.BOSS, 2 },
        { 'Animated_Great_Axe',    mobType.BOSS, 2 },
        { 'Animated_Gun',          mobType.BOSS, 2 },
        { 'Animated_Hammer',       mobType.BOSS, 2 },
        { 'Animated_Horn',         mobType.BOSS, 2 },
        { 'Animated_Knuckles',     mobType.BOSS, 2 },
        { 'Animated_Kunai',        mobType.BOSS, 2 },
        { 'Animated_Longbow',      mobType.BOSS, 2 },
        { 'Animated_Longsword',    mobType.BOSS, 2 },
        { 'Animated_Scythe',       mobType.BOSS, 2 },
        { 'Animated_Shield',       mobType.BOSS, 2 },
        { 'Animated_Spear',        mobType.BOSS, 2 },
        { 'Animated_Staff',        mobType.BOSS, 2 },
        { 'Animated_Tabar',        mobType.BOSS, 2 },
        { 'Animated_Tachi',        mobType.BOSS, 2 },
        { 'Count_Raum',            mobType.NORMAL, 3 },
        { 'Count_Vine',            mobType.NORMAL, 3 },
        { 'Count_Zaebos',          mobType.NORMAL, 3 },
        { 'Duke_Berith',           mobType.NORMAL, 3 },
        { 'Duke_Gomory',           mobType.NORMAL, 3 },
        { 'Duke_Scox',             mobType.NORMAL, 3 },
        { 'Kindred_Bard',          mobType.NORMAL, 2 },
        { 'Kindred_Beastmaster',   mobType.MASTER, 2 },
        { 'Kindred_Black_Mage',    mobType.NORMAL, 2 },
        { 'Kindred_Dark_Knight',   mobType.NORMAL, 2 },
        { 'Kindred_Dragoon',       mobType.MASTER, 2 },
        { 'Kindred_Monk',          mobType.NORMAL, 2 },
        { 'Kindred_Ninja',         mobType.NORMAL, 2 },
        { 'Kindred_Paladin',       mobType.NORMAL, 2 },
        { 'Kindred_Ranger',        mobType.NORMAL, 2 },
        { 'Kindred_Red_Mage',      mobType.NORMAL, 2 },
        { 'Kindred_Samurai',       mobType.NORMAL, 2 },
        { 'Kindred_Summoner',      mobType.MASTER, 2 },
        { 'Kindred_Thief',         mobType.NORMAL, 2 },
        { 'Kindreds_Vouivre',      mobType.NORMAL, 2 },
        { 'Kindred_Warrior',       mobType.NORMAL, 2 },
        { 'Kindred_White_Mage',    mobType.NORMAL, 2 },
        { 'Kindreds_Wyvern',       mobType.NORMAL, 2 },
        { 'King_Zagan',            mobType.MASTER, 3 },
        { 'Marquis_Andras',        mobType.MASTER, 3 },
        { 'Andrass_Vouivre',       mobType.NORMAL, 3 },
        { 'Marquis_Cimeries',      mobType.NORMAL, 3 },
        { 'Marquis_Decarabia',     mobType.NORMAL, 3 },
        { 'Marquis_Gamygyn',       mobType.NORMAL, 3 },
        { 'Marquis_Nebiros',       mobType.MASTER, 3 },
        { 'Marquis_Orias',         mobType.NORMAL, 3 },
        { 'Marquis_Sabnak',        mobType.NORMAL, 3 },
        { 'Prince_Seere',          mobType.NORMAL, 3 },
        { 'Satellite_Claymores',   mobType.NORMAL, 2 },
        { 'Satellite_Daggers',     mobType.NORMAL, 2 },
        { 'Satellite_Great_Axes',  mobType.NORMAL, 2 },
        { 'Satellite_Guns',        mobType.NORMAL, 2 },
        { 'Satellite_Hammers',     mobType.NORMAL, 2 },
        { 'Satellite_Horns',       mobType.NORMAL, 2 },
        { 'Satellite_Knuckles',    mobType.NORMAL, 2 },
        { 'Satellite_Kunai',       mobType.NORMAL, 2 },
        { 'Satellite_Longbows',    mobType.NORMAL, 2 },
        { 'Satellite_Longswords',  mobType.NORMAL, 2 },
        { 'Satellite_Scythes',     mobType.NORMAL, 2 },
        { 'Satellite_Shield',      mobType.NORMAL, 2 },
        { 'Satellite_Spears',      mobType.NORMAL, 2 },
        { 'Satellite_Staves',      mobType.NORMAL, 2 },
        { 'Satellite_Tabars',      mobType.NORMAL, 2 },
        { 'Satellite_Tachi',       mobType.NORMAL, 2 },
        { 'Vanguard_Dragon',       mobType.NORMAL, 2 },
        { 'Yang',                  mobType.NORMAL, 3 },
        { 'Ying',                  mobType.NORMAL, 3 },
        { 'Zagans_Wyvern',         mobType.NORMAL, 2 },
        { 'Kindreds_Avatar', mobType.AVATAR, 2 },
        { 'Nebiross_Avatar', mobType.AVATAR, 3 },
    },
    ['Dynamis-Valkurm'] =
    {
        { 'Cirrate_Christelle',     mobType.BOSS     , 3 },
        { 'Adamantking_Effigy',     mobType.STATUE   , 2 },
        { 'Goblin_Replica',         mobType.STATUE   , 2 },
        { 'Manifest_Icon',          mobType.STATUE   , 2 },
        { 'Warchief_Tombstone',     mobType.STATUE   , 2 },
        { 'Fairy_Ring',             mobType.NORMAL   , 3 },
        { 'Nantina',                mobType.NORMAL   , 3 },
        { 'Stcemqestcint',          mobType.NORMAL   , 3 },
        { 'Nightmare_Fly',          mobType.NORMAL   , 3 },
        { 'Nightmare_Morbol',       mobType.NIGHTMARE, 2 },
        { 'Nightmare_Hippogryph',   mobType.NIGHTMARE, 3 },
        { 'Nightmare_Manticore',    mobType.NIGHTMARE, 3 },
        { 'Nightmare_Sabotender',   mobType.NIGHTMARE, 3 },
        { 'Nightmare_Sheep',        mobType.NIGHTMARE, 3 },
        { 'Dragontrap',             mobType.NIGHTMARE, 3 },
        { 'Vanguard_Alchemist',     mobType.NORMAL   , 2 },
        { 'Vanguard_Ambusher',      mobType.NORMAL   , 2 },
        { 'Vanguard_Amputator',     mobType.NORMAL   , 2 },
        { 'Vanguard_Armorer',       mobType.NORMAL   , 2 },
        { 'Vanguard_Assassin',      mobType.NORMAL   , 2 },
        { 'Vanguard_Backstabber',   mobType.NORMAL   , 2 },
        { 'Vanguard_Beasttender',   mobType.MASTER   , 2 },
        { 'Vanguard_Bugler',        mobType.NORMAL   , 2 },
        { 'Vanguard_Chanter',       mobType.NORMAL   , 2 },
        { 'Vanguard_Constable',     mobType.NORMAL   , 2 },
        { 'Vanguard_Defender',      mobType.NORMAL   , 2 },
        { 'Vanguard_Dollmaster',    mobType.MASTER   , 2 },
        { 'Vanguard_Dragontamer',   mobType.MASTER   , 2 },
        { 'Vanguard_Drakekeeper',   mobType.MASTER   , 2 },
        { 'Vanguard_Enchanter',     mobType.NORMAL   , 2 },
        { 'Vanguard_Exemplar',      mobType.NORMAL   , 2 },
        { 'Vanguard_Footsoldier',   mobType.NORMAL   , 2 },
        { 'Vanguard_Grappler',      mobType.NORMAL   , 2 },
        { 'Vanguard_Gutslasher',    mobType.NORMAL   , 2 },
        { 'Vanguard_Hatamoto',      mobType.NORMAL   , 2 },
        { 'Vanguard_Hawker',        mobType.MASTER   , 2 },
        { 'Vanguard_Hitman',        mobType.NORMAL   , 2 },
        { 'Vanguard_Impaler',       mobType.MASTER   , 2 },
        { 'Vanguard_Inciter',       mobType.NORMAL   , 2 },
        { 'Vanguard_Kusa',          mobType.NORMAL   , 2 },
        { 'Vanguard_Liberator',     mobType.NORMAL   , 2 },
        { 'Vanguard_Maestro',       mobType.NORMAL   , 2 },
        { 'Vanguard_Mason',         mobType.NORMAL   , 2 },
        { 'Vanguard_Mesmerizer',    mobType.NORMAL   , 2 },
        { 'Vanguard_Militant',      mobType.NORMAL   , 2 },
        { 'Vanguard_Minstrel',      mobType.NORMAL   , 2 },
        { 'Vanguard_Neckchopper',   mobType.NORMAL   , 2 },
        { 'Vanguard_Necromancer',   mobType.MASTER   , 2 },
        { 'Vanguard_Ogresoother',   mobType.MASTER   , 2 },
        { 'Vanguard_Oracle',        mobType.MASTER   , 2 },
        { 'Vanguard_Partisan',      mobType.MASTER   , 2 },
        { 'Vanguard_Pathfinder',    mobType.MASTER   , 2 },
        { 'Vanguard_Persecutor',    mobType.NORMAL   , 2 },
        { 'Vanguard_Pillager',      mobType.NORMAL   , 2 },
        { 'Vanguard_Pitfighter',    mobType.NORMAL   , 2 },
        { 'Vanguard_Predator',      mobType.NORMAL   , 2 },
        { 'Vanguard_Prelate',       mobType.NORMAL   , 2 },
        { 'Vanguard_Priest',        mobType.NORMAL   , 2 },
        { 'Vanguard_Protector',     mobType.NORMAL   , 2 },
        { 'Vanguard_Purloiner',     mobType.NORMAL   , 2 },
        { 'Vanguard_Ronin',         mobType.NORMAL   , 2 },
        { 'Vanguard_Salvager',      mobType.NORMAL   , 2 },
        { 'Vanguard_Sentinel',      mobType.NORMAL   , 2 },
        { 'Vanguard_Shaman',        mobType.NORMAL   , 2 },
        { 'Vanguard_Skirmisher',    mobType.NORMAL   , 2 },
        { 'Vanguard_Smithy',        mobType.NORMAL   , 2 },
        { 'Vanguard_Thaumaturge',   mobType.NORMAL   , 2 },
        { 'Vanguard_Tinkerer',      mobType.NORMAL   , 2 },
        { 'Vanguard_Trooper',       mobType.NORMAL   , 2 },
        { 'Vanguard_Undertaker',    mobType.MASTER   , 2 },
        { 'Vanguard_Vexer',         mobType.NORMAL   , 2 },
        { 'Vanguard_Vigilante',     mobType.NORMAL   , 2 },
        { 'Vanguard_Vindicator',    mobType.NORMAL   , 2 },
        { 'Vanguard_Visionary',     mobType.NORMAL   , 2 },
        { 'Vanguard_Welldigger',    mobType.NORMAL   , 2 },
        { 'Vanguards_Crow',         mobType.NORMAL   , 2 },
        { 'Vanguards_Hecteyes',     mobType.NORMAL   , 1 },
        { 'Vanguards_Scorpion',     mobType.NORMAL   , 2 },
        { 'Vanguards_Slime',        mobType.NORMAL   , 2 },
        { 'Vanguards_Wyvern',       mobType.NORMAL   , 2 },
        { 'Vanguards_Avatar',       mobType.AVATAR   , 1 },
    },
    ['Dynamis-Buburimu'] =
    {
        { 'Apocalyptic_Beast',        mobType.BOSS     , 3 },
        { 'Dragons_Avatar',           mobType.NORMAL   , 1 },
        { 'Dragons_Wyvern',           mobType.NORMAL   , 1 },
        { 'Adamantking_Effigy',       mobType.STATUE   , 2 },
        { 'Manifest_Icon',            mobType.STATUE   , 2 },
        { 'Warchief_Tombstone',       mobType.STATUE   , 2 },
        { 'Goblin_Replica',           mobType.STATUE   , 2 },
        { 'Nightmare_Bunny',          mobType.NIGHTMARE, 2 },
        { 'Nightmare_Cockatrice',     mobType.NIGHTMARE, 2 },
        { 'Nightmare_Crab',           mobType.NIGHTMARE, 2 },
        { 'Nightmare_Crawler',        mobType.NIGHTMARE, 2 },
        { 'Nightmare_Dhalmel',        mobType.NIGHTMARE, 2 },
        { 'Nightmare_Eft',            mobType.NIGHTMARE, 2 },
        { 'Nightmare_Mandragora',     mobType.NIGHTMARE, 2 },
        { 'Nightmare_Raven',          mobType.NIGHTMARE, 2 },
        { 'Nightmare_Scorpion',       mobType.NIGHTMARE, 2 },
        { 'Nightmare_Uragnite',       mobType.NIGHTMARE, 2 },
        { 'Baa_Dava_the_Bibliophage', mobType.MASTER   , 2 },
        { 'Doo_Peku_the_Fleetfoot',   mobType.NORMAL   , 2 },
        { 'Elvaansticker_Bxafraff',   mobType.MASTER   , 2 },
        { 'Bxafraffs_Wyvern',         mobType.NORMAL   , 2 },
        { 'Flamecaller_Zoeqdoq',      mobType.NORMAL   , 2 },
        { 'GiBhe_Fleshfeaster',       mobType.NORMAL   , 2 },
        { 'Gosspix_Blabberlips',      mobType.NORMAL   , 2 },
        { 'Hamfist_Gukhbuk',          mobType.NORMAL   , 2 },
        { 'Koo_Rahi_the_Levinblade',  mobType.NORMAL   , 2 },
        { 'Lyncean_Juwgneg',          mobType.NORMAL   , 2 },
        { 'QuPho_Bloodspiller',       mobType.NORMAL   , 2 },
        { 'Ree_Nata_the_Melomanic',   mobType.NORMAL   , 2 },
        { 'Shamblix_Rottenheart',     mobType.NORMAL   , 2 },
        { 'TeZha_Ironclad',           mobType.NORMAL   , 2 },
        { 'Vanguard_Alchemist',       mobType.NORMAL   , 2 },
        { 'Vanguard_Ambusher',        mobType.NORMAL   , 2 },
        { 'Vanguard_Amputator',       mobType.NORMAL   , 2 },
        { 'Vanguard_Armorer',         mobType.NORMAL   , 2 },
        { 'Vanguard_Assassin',        mobType.NORMAL   , 2 },
        { 'Vanguard_Backstabber',     mobType.NORMAL   , 2 },
        { 'Vanguard_Beasttender',     mobType.MASTER   , 2 },
        { 'Vanguard_Bugler',          mobType.NORMAL   , 2 },
        { 'Vanguard_Chanter',         mobType.NORMAL   , 2 },
        { 'Vanguard_Constable',       mobType.NORMAL   , 2 },
        { 'Vanguard_Defender',        mobType.NORMAL   , 2 },
        { 'Vanguard_Dollmaster',      mobType.MASTER   , 2 },
        { 'Vanguard_Dragontamer',     mobType.MASTER   , 2 },
        { 'Vanguard_Drakekeeper',     mobType.MASTER   , 2 },
        { 'Vanguard_Enchanter',       mobType.NORMAL   , 2 },
        { 'Vanguard_Exemplar',        mobType.NORMAL   , 2 },
        { 'Vanguard_Footsoldier',     mobType.NORMAL   , 2 },
        { 'Vanguard_Grappler',        mobType.NORMAL   , 2 },
        { 'Vanguard_Gutslasher',      mobType.NORMAL   , 2 },
        { 'Vanguard_Hatamoto',        mobType.NORMAL   , 2 },
        { 'Vanguard_Hawker',          mobType.MASTER   , 2 },
        { 'Vanguard_Hitman',          mobType.NORMAL   , 2 },
        { 'Vanguard_Impaler',         mobType.MASTER   , 2 },
        { 'Vanguard_Inciter',         mobType.NORMAL   , 2 },
        { 'Vanguard_Kusa',            mobType.NORMAL   , 2 },
        { 'Vanguard_Liberator',       mobType.NORMAL   , 2 },
        { 'Vanguard_Maestro',         mobType.NORMAL   , 2 },
        { 'Vanguard_Mason',           mobType.NORMAL   , 2 },
        { 'Vanguard_Mesmerizer',      mobType.NORMAL   , 2 },
        { 'Vanguard_Militant',        mobType.NORMAL   , 2 },
        { 'Vanguard_Minstrel',        mobType.NORMAL   , 2 },
        { 'Vanguard_Neckchopper',     mobType.NORMAL   , 2 },
        { 'Vanguard_Necromancer',     mobType.MASTER   , 2 },
        { 'Vanguard_Ogresoother',     mobType.MASTER   , 2 },
        { 'Vanguard_Oracle',          mobType.MASTER   , 2 },
        { 'Vanguard_Partisan',        mobType.MASTER   , 2 },
        { 'Vanguard_Pathfinder',      mobType.MASTER   , 2 },
        { 'Vanguard_Persecutor',      mobType.NORMAL   , 2 },
        { 'Vanguard_Pillager',        mobType.NORMAL   , 2 },
        { 'Vanguard_Pitfighter',      mobType.NORMAL   , 2 },
        { 'Vanguard_Predator',        mobType.NORMAL   , 2 },
        { 'Vanguard_Prelate',         mobType.NORMAL   , 2 },
        { 'Vanguard_Priest',          mobType.NORMAL   , 2 },
        { 'Vanguard_Protector',       mobType.NORMAL   , 2 },
        { 'Vanguard_Purloiner',       mobType.NORMAL   , 2 },
        { 'Vanguard_Ronin',           mobType.NORMAL   , 2 },
        { 'Vanguard_Salvager',        mobType.NORMAL   , 2 },
        { 'Vanguard_Sentinel',        mobType.NORMAL   , 2 },
        { 'Vanguard_Shaman',          mobType.NORMAL   , 2 },
        { 'Vanguard_Skirmisher',      mobType.NORMAL   , 2 },
        { 'Vanguard_Smithy',          mobType.NORMAL   , 2 },
        { 'Vanguard_Thaumaturge',     mobType.NORMAL   , 2 },
        { 'Vanguard_Tinkerer',        mobType.NORMAL   , 2 },
        { 'Vanguard_Trooper',         mobType.NORMAL   , 2 },
        { 'Vanguard_Undertaker',      mobType.MASTER   , 2 },
        { 'Vanguard_Vexer',           mobType.NORMAL   , 2 },
        { 'Vanguard_Vigilante',       mobType.NORMAL   , 2 },
        { 'Vanguard_Vindicator',      mobType.NORMAL   , 2 },
        { 'Vanguard_Visionary',       mobType.NORMAL   , 2 },
        { 'Vanguard_Welldigger',      mobType.NORMAL   , 2 },
        { 'Vanguards_Crow',           mobType.NORMAL   , 2 },
        { 'Vanguards_Hecteyes',       mobType.NORMAL   , 1 },
        { 'Vanguards_Scorpion',       mobType.NORMAL   , 2 },
        { 'Vanguards_Slime',          mobType.NORMAL   , 2 },
        { 'Vanguards_Wyvern',         mobType.NORMAL   , 2 },
        { 'VaRhu_Bodysnatcher',       mobType.NORMAL   , 2 },
        { 'Woodnix_Shrillwhistle',    mobType.MASTER   , 2 },
        { 'Woodnixs_Slime',           mobType.NORMAL   , 2 },
        { 'Aitvaras',                 mobType.BOSS     , 3 },
        { 'Alklha',                   mobType.BOSS     , 3 },
        { 'Barong',                   mobType.BOSS     , 3 },
        { 'Basilic',                  mobType.BOSS     , 3 },
        { 'Koshchei',                 mobType.BOSS     , 3 },
        { 'Stihi',                    mobType.BOSS     , 3 },
        { 'Stollenwurm',              mobType.BOSS     , 3 },
        { 'Tarasca',                  mobType.BOSS     , 3 },
        { 'Jurik',                    mobType.BOSS     , 3 },
        { 'Vishap',                   mobType.BOSS     , 3 },
        { 'Vanguards_Avatar', mobType.AVATAR, 2 },
        { 'Baas_Avatar', mobType.AVATAR, 2 },
    },
    ['Dynamis-Qufim'] =
    {
        { 'Antaeus',                  mobType.BOSS     , 3 },
        { 'Scolopendra',              mobType.BOSS     , 2 },
        { 'Suttung',                  mobType.BOSS     , 2 },
        { 'Stringes',                 mobType.BOSS     , 2 },
        { 'Warchief_Tombstone',       mobType.STATUE   , 1 },
        { 'Manifest_Icon',            mobType.STATUE   , 1 },
        { 'Adamantking_Effigy',       mobType.STATUE   , 1 },
        { 'Goblin_Replica',           mobType.STATUE   , 1 },
        { 'Vanguard_Grappler',        mobType.NORMAL   , 1 },
        { 'Vanguard_Amputator',       mobType.NORMAL   , 1 },
        { 'Vanguard_Backstabber',     mobType.NORMAL   , 1 },
        { 'Vanguard_Trooper',         mobType.NORMAL   , 1 },
        { 'Vanguard_Bugler',          mobType.NORMAL   , 1 },
        { 'Vanguard_Impaler',         mobType.MASTER   , 1 },
        { 'Vanguards_Wyvern',         mobType.NORMAL   , 1 },
        { 'Vanguard_Neckchopper',     mobType.NORMAL   , 1 },
        { 'Vanguard_Vexer',           mobType.NORMAL   , 1 },
        { 'Vanguard_Mesmerizer',      mobType.NORMAL   , 1 },
        { 'Vanguard_Pillager',        mobType.NORMAL   , 1 },
        { 'Vanguard_Dollmaster',      mobType.MASTER   , 1 },
        { 'Vanguard_Footsoldier',     mobType.NORMAL   , 1 },
        { 'Vanguard_Gutslasher',      mobType.NORMAL   , 1 },
        { 'Vanguard_Predator',        mobType.NORMAL   , 1 },
        { 'Vanguard_Hawker',          mobType.MASTER   , 1 },
        { 'Vanguards_Hecteyes',       mobType.NORMAL   , 1 },
        { 'Vanguard_Partisan',        mobType.MASTER   , 1 },
        { 'Vanguard_Exemplar',        mobType.NORMAL   , 1 },
        { 'Vanguard_Prelate',         mobType.NORMAL   , 1 },
        { 'Vanguard_Persecutor',      mobType.NORMAL   , 1 },
        { 'Vanguard_Sentinel',        mobType.NORMAL   , 1 },
        { 'Vanguard_Liberator',       mobType.NORMAL   , 1 },
        { 'Vanguard_Priest',          mobType.NORMAL   , 1 },
        { 'Vanguard_Assassin',        mobType.NORMAL   , 1 },
        { 'Vanguard_Ogresoother',     mobType.MASTER   , 1 },
        { 'Vanguards_Crow',           mobType.NORMAL   , 1 },
        { 'Vanguard_Oracle',          mobType.MASTER   , 1 },
        { 'Vanguard_Skirmisher',      mobType.NORMAL   , 1 },
        { 'Vanguard_Visionary',       mobType.NORMAL   , 1 },
        { 'Vanguard_Chanter',         mobType.NORMAL   , 1 },
        { 'Vanguard_Salvager',        mobType.NORMAL   , 1 },
        { 'Vanguard_Inciter',         mobType.NORMAL   , 1 },
        { 'Vanguard_Vindicator',      mobType.NORMAL   , 1 },
        { 'Vanguard_Protector',       mobType.NORMAL   , 1 },
        { 'Vanguard_Kusa',            mobType.NORMAL   , 1 },
        { 'Vanguard_Militant',        mobType.NORMAL   , 1 },
        { 'Vanguard_Thaumaturge',     mobType.NORMAL   , 1 },
        { 'Vanguard_Purloiner',       mobType.NORMAL   , 1 },
        { 'Vanguard_Defender',        mobType.NORMAL   , 1 },
        { 'Vanguard_Hatamoto',        mobType.NORMAL   , 1 },
        { 'Vanguard_Constable',       mobType.NORMAL   , 1 },
        { 'Vanguard_Beasttender',     mobType.MASTER   , 1 },
        { 'Vanguards_Scorpion',       mobType.NORMAL   , 1 },
        { 'Vanguard_Mason',           mobType.NORMAL   , 1 },
        { 'Vanguard_Vigilante',       mobType.NORMAL   , 1 },
        { 'Vanguard_Drakekeeper',     mobType.MASTER   , 1 },
        { 'Vanguard_Minstrel',        mobType.NORMAL   , 1 },
        { 'Vanguard_Undertaker',      mobType.MASTER   , 1 },
        { 'Vanguard_Pathfinder',      mobType.MASTER   , 1 },
        { 'Vanguards_Slime',          mobType.NORMAL   , 1 },
        { 'Vanguard_Welldigger',      mobType.NORMAL   , 1 },
        { 'Vanguard_Necromancer',     mobType.MASTER   , 1 },
        { 'Vanguard_Maestro',         mobType.NORMAL   , 1 },
        { 'Vanguard_Pitfighter',      mobType.NORMAL   , 1 },
        { 'Vanguard_Dragontamer',     mobType.MASTER   , 1 },
        { 'Vanguard_Hitman',          mobType.NORMAL   , 1 },
        { 'Vanguard_Smithy',          mobType.NORMAL   , 1 },
        { 'Vanguard_Armorer',         mobType.NORMAL   , 1 },
        { 'Vanguard_Enchanter',       mobType.NORMAL   , 1 },
        { 'Vanguard_Shaman',          mobType.NORMAL   , 1 },
        { 'Vanguard_Ronin',           mobType.NORMAL   , 1 },
        { 'Vanguard_Tinkerer',        mobType.NORMAL   , 1 },
        { 'Vanguard_Ambusher',        mobType.NORMAL   , 1 },
        { 'Vanguard_Alchemist',       mobType.NORMAL   , 1 },
        { 'Fire_Elemental',           mobType.NORMAL   , 1 },
        { 'Ice_Elemental',            mobType.NORMAL   , 1 },
        { 'Air_Elemental',            mobType.NORMAL   , 1 },
        { 'Earth_Elemental',          mobType.NORMAL   , 1 },
        { 'Thunder_Elemental',        mobType.NORMAL   , 1 },
        { 'Water_Elemental',          mobType.NORMAL   , 1 },
        { 'Light_Elemental',          mobType.NORMAL   , 1 },
        { 'Dark_Elemental',           mobType.NORMAL   , 1 },
        { 'Nightmare_Snoll',          mobType.NIGHTMARE, 1 },
        { 'Nightmare_Roc',            mobType.NIGHTMARE, 1 },
        { 'Nightmare_Stirge',         mobType.NIGHTMARE, 1 },
        { 'Nightmare_Diremite',       mobType.NIGHTMARE, 1 },
        { 'Nightmare_Kraken',         mobType.NIGHTMARE, 1 },
        { 'Nightmare_Gaylas',         mobType.NIGHTMARE, 1 },
        { 'Nightmare_Raptor',         mobType.NIGHTMARE, 1 },
        { 'Nightmare_Tiger',          mobType.NIGHTMARE, 1 },
        { 'Nightmare_Weapon',         mobType.NIGHTMARE, 1 },
        { 'Vanguards_Avatar', mobType.AVATAR, 1 },
    },
    ['Dynamis-Tavnazia'] =
    {
        { 'Diabolos_Club',       mobType.MASTER   , 1 },
        { 'Diabolos_Diamond',    mobType.NORMAL   , 1 },
        { 'Diabolos_Heart',      mobType.NORMAL   , 1 },
        { 'Diabolos_Spade',      mobType.NORMAL   , 1 },
        { 'Umbral_Diabolos',     mobType.NORMAL   , 1 },
        { 'Diaboloss_Shard',     mobType.NORMAL   , 1 },
        { 'Vanguard_Eye',        mobType.STATUE   , 1 },
        { 'Hydra_Bard',          mobType.NORMAL   , 2 },
        { 'Hydra_Beastmaster',   mobType.MASTER   , 2 },
        { 'Hydra_Black_Mage',    mobType.NORMAL   , 2 },
        { 'Hydra_Dark_Knight',   mobType.NORMAL   , 2 },
        { 'Hydra_Dragoon',       mobType.MASTER   , 2 },
        { 'Hydra_Monk',          mobType.NORMAL   , 2 },
        { 'Hydra_Ninja',         mobType.NORMAL   , 2 },
        { 'Hydra_Paladin',       mobType.NORMAL   , 2 },
        { 'Hydra_Ranger',        mobType.NORMAL   , 2 },
        { 'Hydra_Red_Mage',      mobType.NORMAL   , 2 },
        { 'Hydra_Samurai',       mobType.NORMAL   , 2 },
        { 'Hydra_Summoner',      mobType.MASTER   , 2 },
        { 'Hydra_Thief',         mobType.NORMAL   , 2 },
        { 'Hydra_Warrior',       mobType.NORMAL   , 2 },
        { 'Hydra_White_Mage',    mobType.NORMAL   , 2 },
        { 'Hydras_Hound',        mobType.NORMAL   , 2 },
        { 'Hydras_Wyvern',       mobType.NORMAL   , 2 },
        { 'Kindred_Bard',        mobType.NORMAL   , 2 },
        { 'Kindred_Beastmaster', mobType.MASTER   , 2 },
        { 'Kindred_Black_Mage',  mobType.NORMAL   , 2 },
        { 'Kindred_Dark_Knight', mobType.NORMAL   , 2 },
        { 'Kindred_Dragoon',     mobType.MASTER   , 2 },
        { 'Kindred_Monk',        mobType.NORMAL   , 2 },
        { 'Kindred_Ninja',       mobType.NORMAL   , 2 },
        { 'Kindred_Paladin',     mobType.NORMAL   , 2 },
        { 'Kindred_Ranger',      mobType.NORMAL   , 2 },
        { 'Kindred_Red_Mage',    mobType.NORMAL   , 2 },
        { 'Kindred_Samurai',     mobType.NORMAL   , 2 },
        { 'Kindred_Summoner',    mobType.MASTER   , 2 },
        { 'Kindred_Thief',       mobType.NORMAL   , 2 },
        { 'Kindred_Warrior',     mobType.NORMAL   , 2 },
        { 'Kindred_White_Mage',  mobType.NORMAL   , 2 },
        { 'Kindreds_Vouivre',    mobType.NORMAL   , 2 },
        { 'Kindreds_Wyvern',     mobType.NORMAL   , 2 },
        { 'Nightmare_Antlion',   mobType.NIGHTMARE, 2 },
        { 'Nightmare_Bugard',    mobType.NIGHTMARE, 3 },
        { 'Nightmare_Cluster',   mobType.NIGHTMARE, 2 },
        { 'Nightmare_Hornet',    mobType.NIGHTMARE, 2 },
        { 'Nightmare_Leech',     mobType.NIGHTMARE, 2 },
        { 'Nightmare_Makara',    mobType.NIGHTMARE, 2 },
        { 'Nightmare_Taurus',    mobType.NIGHTMARE, 2 },
        { 'Nightmare_Worm',      mobType.NIGHTMARE, 2 },
        { 'Hydras_Avatar', mobType.AVATAR, 2 },
        { 'Kindreds_Avatar', mobType.AVATAR, 2 },
    }
}

-- Helper function for dynamis zone overrides in order to provide clear structure (hopefully?)
-- This overrides the zone scripts for dynamis zones to call dynamis functions
-- onInitialize
-- onZoneOut
-- onZoneIn
-- onZoneTick
-- Special cases for SJ zones (7-9) and Tavnazia (10) for NPCs qm0 and qm1
local function registerDynamisZoneOverrides(zoneID, zoneName, zoneNumber)
    m:addOverride(string.format('xi.zones.%s.Zone.onInitialize', zoneName),
    function(zone)
        -- Clean left over vars on restarts
        xi.dynamis.clearOnInit(zone)

        if zoneID == xi.zone.DYNAMIS_TAVNAZIA then
            xi.dynamis.onZoneInitTav(zone)
        end
    end)

    m:addOverride(string.format('xi.zones.%s.Zone.onZoneIn', zoneName),
    function(player, prevZone)
        return xi.dynamis.zoneOnZoneInEra(player, prevZone)
    end)

    m:addOverride(string.format('xi.zones.%s.Zone.onZoneTick', zoneName),
    function(zone)
        xi.dynamis.dynamisTick(zone)
    end)

    -- Special case for SJ zones (7-9)
    -- Dynamis - Buburimu (8), Dynamis - Qufim (9)
    if zoneID == xi.zone.DYNAMIS_BUBURIMU or zoneID == xi.zone.DYNAMIS_QUFIM then
        m:addOverride(string.format('xi.zones.%s.npcs.qm1.onTrigger', zoneName),
        function(player, npc)
            xi.dynamis.sjQMOnTrigger(player, npc)
        end)
    end

    -- Special case for Tavnazia (10)
    if zoneNumber == 10 then
        -- Time extension QMs
        m:addOverride(string.format('xi.zones.Dynamis-Tavnazia.npcs.qm1.onTrigger', zoneName),
        function(player, npc)
            xi.dynamis.teOnTrigger(player, npc)
        end)

        m:addOverride(string.format('xi.zones.Dynamis-Tavnazia.npcs.qm1.onTrade', zoneName),
        function(player, npc)
        end)

        m:addOverride(string.format('xi.zones.Dynamis-Tavnazia.npcs.qm2.onTrigger', zoneName),
        function(player, npc)
            xi.dynamis.teOnTrigger(player, npc)
        end)

        m:addOverride(string.format('xi.zones.Dynamis-Tavnazia.npcs.qm2.onTrade', zoneName),
        function(player, npc)
        end)

        -- Trigger areas
        m:addOverride(string.format('xi.zones.Dynamis-Tavnazia.Zone.onTriggerAreaEnter', zoneName),
        function(player, triggerArea)
            xi.dynamis.onTriggerAreaEnterTav(player, triggerArea)
        end)
    end
end

-- Helper function for entry NPC overrides
local function registerEntryNpcOverrides(zoneName, npcName)
    m:addOverride(string.format('xi.zones.%s.npcs.%s.onTrade', zoneName, npcName),
    function(player, npc, trade)
        xi.dynamis.debugPrint('1. Trail markings on trade working')
        xi.dynamis.entryNpcOnTrade(player, npc, trade)
    end)

    m:addOverride(string.format('xi.zones.%s.npcs.%s.onEventUpdate', zoneName, npcName),
    function(player, csid, option, npc)
        xi.dynamis.entryNpcOnEventUpdate(player, csid, option, npc)
        xi.dynamis.debugPrint('2. Trail markings on event update working')
    end)

    m:addOverride(string.format('xi.zones.%s.npcs.%s.onEventFinish', zoneName, npcName),
    function(player, csid, option, npc)
        xi.dynamis.entryNpcOnEventFinish(player, csid, option, npc)
        xi.dynamis.debugPrint('Trail markings on event finish working')
    end)
end

-- Register all overrides with a simple loop instead of repeating code
for _, zone in pairs(dynamisZones) do
    registerDynamisZoneOverrides(zone[1], zone[2], zone[3])
end

for _, zone in pairs(startingZones) do
    registerEntryNpcOverrides(zone[1], zone[2])
end

-- Disable Base LSB Additional Functions
m:addOverride('xi.dynamis.entryNpcOnTrigger', function(player, npc)
    xi.dynamis.entryNpcOnTriggerEra(player, npc)
end)

m:addOverride('xi.dynamis.entryNpcOnEventFinish', function(player, csid, option)
    xi.dynamis.entryNpcOnEventFinishEra(player, csid, option)
end)

m:addOverride('xi.dynamis.qmOnTrigger', function(player, npc) -- Override standard qmOnTrigger()
    xi.dynamis.qmOnTriggerEra(player, npc)
end)

m:addOverride('xi.dynamis.qmOnTrade', function(player, npc, trade)
    -- No trade functions for era dynamis
end)

m:addOverride('xi.dynamis.procMonster', function(player)
    -- Removes proc system
end)

-----------------------------------
-- Mob Type Overrides
-----------------------------------
local function noMobDespawn()
end

-- Zone and mob specific hooks for special NM behavior
-- The functions you call must bc xi.dynamis.[functionamme] and the parameters must bc the same as the original functions
local specialMobHooks =
{
    ['Dynamis-Buburimu'] =
    {
        -- Example
        -- Aitvaras =
        -- {
        --     onMobSpawn = 'aitvarasSpawn',
        -- },
        -- Alklha =
        -- {
        --     onMobSpawn = 'alklhaSpawn',
        -- },
        Apocalyptic_Beast =
        {
            onMobSpawn          = 'onApocSpawn',
            onMobEngage         = 'onApocEngage',
            onMobFight          = 'onApocFight',
            onMobSpellChoose    = 'onApocSpellChoose',
            onMobMobskillChoose = 'onApocMobskillChoose',
            onMobRoam           = 'onApocRoam',
        },
        Aitvaras =
        {
            onMobSpawn = 'onSpawnBubuDragon',
            onMobFight = 'onFightDragon',
            onMobRoam  = 'onRoamDragon',
        },
        Alklha =
        {
            onMobSpawn = 'onSpawnBubuDragon',
            onMobFight = 'onFightDragon',
            onMobRoam  = 'onRoamDragon',
        },
        Barong =
        {
            onMobSpawn = 'onSpawnBubuDragon',
            onMobFight = 'onFightDragon',
            onMobRoam  = 'onRoamDragon',
        },
        Basilic =
        {
            onMobSpawn = 'onSpawnBubuDragon',
            onMobFight = 'onFightDragon',
            onMobRoam  = 'onRoamDragon',
        },
        Koshchei =
        {
            onMobSpawn = 'onSpawnBubuDragon',
            onMobFight = 'onFightDragon',
            onMobRoam  = 'onRoamDragon',
        },
        Stihi =
        {
            onMobSpawn = 'onSpawnBubuDragon',
            onMobFight = 'onFightDragon',
            onMobRoam  = 'onRoamDragon',
        },
        Stollenwurm =
        {
            onMobSpawn = 'onSpawnBubuDragon',
            onMobFight = 'onFightDragon',
            onMobRoam  = 'onRoamDragon',
        },
        Tarasca =
        {
            onMobSpawn = 'onSpawnBubuDragon',
            onMobFight = 'onFightDragon',
            onMobRoam  = 'onRoamDragon',
        },
        Jurik =
        {
            onMobSpawn = 'onSpawnBubuDragon',
            onMobFight = 'onFightDragon',
            onMobRoam  = 'onRoamDragon',
        },
        Vishap =
        {
            onMobSpawn = 'onSpawnBubuDragon',
            onMobFight = 'onFightDragon',
            onMobRoam  = 'onRoamDragon',
        },
    },
}

-- target is the engage/fight target, or the killer player for onMobDeath
local function runSpecialMobHook(zoneName, mobName, eventName, modelSize, mob, target, optParams)
    local zoneHooks = specialMobHooks[zoneName]
    if not zoneHooks then
        return
    end

    local mobHooks = zoneHooks[mobName]
    if not mobHooks then
        return
    end

    local hook = mobHooks[eventName]
    if not hook then
        return
    end

    if type(hook) == 'string' then
        hook = xi.dynamis[hook]
    end

    if type(hook) == 'function' then
        if eventName == 'onMobSpawn' then
            hook(mob, modelSize)
        else
            hook(mob, target, optParams)
        end
    end
end

local function hasSpecialMobHook(zoneName, mobName, eventName)
    local zoneHooks = specialMobHooks[zoneName]
    local mobHooks  = zoneHooks and zoneHooks[mobName]

    return mobHooks and mobHooks[eventName] ~= nil
end

local mobOverrideHandlers =
{
    [mobType.STATUE] =
    {
        onMobInitialize = function(mob)
            xi.dynamis.onSharedInitialize(mob)
        end,

        onMobEngage = function(mob, target)
            xi.dynamis.onSharedEngage(mob, target)
            xi.dynamis.checkEyeColor(mob)
        end,

        onMobRoam = function(mob)
            xi.dynamis.onMobRoam(mob)
        end,

        onMobDisengage = function(mob)
            xi.dynamis.onMobDisengage(mob)
        end,

        onMobFight = function(mob, target)
            xi.dynamis.onStatueFight(mob, target)
        end,

        onMobDeath = function(mob, player, optParams)
            xi.dynamis.onStatueDeath(mob, player, optParams)
        end,

        onMobDespawn = noMobDespawn,
    },

    [mobType.BOSS] =
    {
        onMobInitialize = function(mob)
            xi.dynamis.onSharedInitialize(mob)
            xi.dynamis.onBossInitialize(mob)
        end,

        onMobEngage = function(mob, target)
            xi.dynamis.onSharedEngage(mob, target)
            xi.dynamis.onBossEngage(mob, target)
        end,

        onMobDisengage = function(mob)
            xi.dynamis.onMobDisengage(mob)
        end,

        onMobRoam = function(mob)
            xi.dynamis.onMobRoam(mob)
            xi.dynamis.onBossRoam(mob)
        end,

        onMobDeath = function(mob, player, optParams)
            xi.dynamis.onBossDeath(mob, player, optParams)
        end,

        onMobDespawn = noMobDespawn,
    },

    [mobType.NORMAL] =
    {
        onMobInitialize = function(mob)
            xi.dynamis.onSharedInitialize(mob)
        end,

        onMobRoam = function(mob)
            xi.dynamis.onMobRoam(mob)
        end,

        onMobDisengage = function(mob)
            xi.dynamis.onMobDisengage(mob)
        end,

        onMobDeath = function(mob, player, optParams)
            xi.dynamis.onMobDeath(mob, player, optParams)
        end,

        onMobDespawn = noMobDespawn,
    },

    [mobType.MASTER] =
    {
        onMobInitialize = function(mob)
            xi.dynamis.onSharedInitialize(mob)

            local pet = GetMobByID(mob:getID() + 1)
            if pet then
                xi.pet.setMobPet(mob, 1, pet:getName())
            end
        end,

        onMobRoam = function(mob)
            xi.dynamis.onMobRoam(mob)
        end,

        onMobDisengage = function(mob)
            xi.dynamis.onMobDisengage(mob)
        end,

        -- Masters own their 2hr by main job: SMN = Astral Flow (+ avatar resummon), BST = Familiar/Charm
        onMobFight = function(mob, target)
            local masterJob = mob:getMainJob()
            if masterJob == xi.job.SMN then
                xi.dynamis.summonerOnFight(mob, target)
            elseif masterJob == xi.job.BST then
                xi.dynamis.beastmasterOnFight(mob, target)
            end
        end,

        onMobDeath = function(mob, player, optParams)
            xi.dynamis.onMobDeath(mob, player, optParams)
        end,

        onMobDespawn = noMobDespawn,
    },

    [mobType.AVATAR] =
    {
        onMobInitialize = function(mob)
            xi.dynamis.onSharedInitialize(mob)
        end,

        onMobRoam = function(mob)
            xi.dynamis.onMobRoam(mob)
        end,

        onMobDisengage = function(mob)
            xi.dynamis.onMobDisengage(mob)
        end,

        onMobFight = function(mob, target)
            xi.dynamis.avatarOnFight(mob, target)
        end,

        onMobDeath = function(mob, player, optParams)
            xi.dynamis.onMobDeath(mob, player, optParams)
        end,

        onMobDespawn = noMobDespawn,
    },

    [mobType.NIGHTMARE] =
    {
        onMobInitialize = function(mob)
            xi.dynamis.onSharedInitialize(mob)
        end,

        onMobEngage = function(mob, target)
            xi.dynamis.onSharedEngage(mob, target)
        end,

        onMobDisengage = function(mob)
            xi.dynamis.onMobDisengage(mob)
        end,

        onMobRoam = function(mob)
            xi.dynamis.onMobRoam(mob)
        end,

        onMobDeath = function(mob, player, optParams)
            xi.dynamis.onMobDeath(mob, player, optParams)
        end,

        onMobDespawn = noMobDespawn,
    },
}

local mobOverrideOrder =
{
    'onMobInitialize',
    'onMobSpawn',
    'onMobEngage',
    'onMobDisengage',
    'onMobRoam',
    'onMobFight',
    'onMobDeath',
    'onMobDespawn',
}

-- Mobs whose base zone script should keep running (upstream code that matches era)
-- original = run the base script function first (via super), then the era handler
-- only     = base script only; the era module does not override this mob at all (not sure if this will ever be used bc we need to set the rank stats but added it anyway)
-- A table limits 'original' to the listed events, so the era handlers still own everything else
local baseScriptMobs =
{
    ['Dynamis-Xarcabard'] =
    {
        Dynamis_Lord = 'original',
        Ying = 'original',
        Yang = 'original',
    },
    ['Dynamis-Beaucedine'] =
    {
        Angra_Mainyu = { onMobInitialize = 'original', onMobSpawn = 'original' }, -- Graviga/Charm teleport listeners, spell interrupt, teleport and 2hr vars
    },
    ['Dynamis-Valkurm'] =
    {
        Cirrate_Christelle = { onMobSpawn = 'original' }, -- Breath auto attacks, bind/gravity/silence immunity, damage modifier
        Fairy_Ring         = { onMobSpawn = 'original' }, -- Mephitic Spore auto attack, speed, damage modifier
        Nantina            = { onMobSpawn = 'original' }, -- Skill auto attack feeding the Blow/Uppercut/Attractant rotation
        Stcemqestcint      = { onMobSpawn = 'original' }, -- Gouging Branch auto attack
    },
    ['Dynamis-Qufim'] =
    {
        Antaeus     = { onMobInitialize = 'original', onMobSpawn = 'original' }, -- Trebuchet special skill and EES 2hr threshold
        Scolopendra = { onMobSpawn = 'original' }, -- Double attack
    },
}

local function getBaseScriptMode(baseMode, eventName)
    if type(baseMode) == 'table' then
        return baseMode[eventName]
    end

    return baseMode
end

local function registerMobOverrides(zoneName, mobName, overrideMobType, modelSize)
    local mobPath  = string.format('xi.zones.%s.mobs.%s', zoneName, mobName)
    local handlers = mobOverrideHandlers[overrideMobType]
    if not handlers then
        return
    end

    local baseMode = baseScriptMobs[zoneName] and baseScriptMobs[zoneName][mobName]
    if baseMode == 'only' then
        return -- Leave the base zone script fully in charge of this mob
    end

    for _, eventName in ipairs(mobOverrideOrder) do
        local handler       = handlers[eventName]
        local hasMobHook    = hasSpecialMobHook(zoneName, mobName, eventName)
        local eventBaseMode = getBaseScriptMode(baseMode, eventName)

        -- onMobSpawn needs modelSize injected via closure
        if eventName == 'onMobSpawn' then
            if overrideMobType == mobType.STATUE then
                handler = function(mob)
                    xi.dynamis.statueOnSpawn(mob, modelSize)
                end
            elseif overrideMobType == mobType.BOSS then
                handler = function(mob)
                    xi.dynamis.generalInfo(mob, modelSize)
                    xi.dynamis.onBossSpawn(mob, modelSize)
                end
            elseif overrideMobType == mobType.NIGHTMARE then
                handler = function(mob)
                    xi.dynamis.onMobSpawn(mob, overrideMobType, modelSize)
                    xi.dynamis.generatePath(mob, modelSize)
                end
            elseif overrideMobType == mobType.MASTER then
                handler = function(mob)
                    xi.dynamis.onMobSpawn(mob, overrideMobType, modelSize)
                    xi.dynamis.masterOnSpawn(mob)
                end
            elseif overrideMobType == mobType.AVATAR then
                handler = function(mob)
                    xi.dynamis.onMobSpawn(mob, overrideMobType, modelSize)
                    xi.dynamis.avatarOnSpawn(mob)
                end
            else
                handler = function(mob)
                    xi.dynamis.onMobSpawn(mob, overrideMobType, modelSize)
                end
            end

            -- Base mob scripts attach scripts/mixins/dynamis_beastmen at zone load, outside addOverride's reach.
            local spawnHandler = handler
            handler = function(mob)
                mob:removeListener('DYNAMIS_ITEM_DISTRIBUTION')
                mob:removeListener('DYNAMIS_MAGIC_PROC_CHECK')
                mob:removeListener('DYNAMIS_WS_PROC_CHECK')
                mob:removeListener('DYNAMIS_ABILITY_PROC_CHECK')
                spawnHandler(mob)
            end
        end

        if handler or hasMobHook then
            -- target is the engage/fight target, or the killer player for onMobDeath
            m:addOverride(mobPath .. '.' .. eventName, function(mob, target, optParams)
                -- run the original code first
                if eventBaseMode == 'original' then
                    super(mob, target, optParams)
                end

                if handler then
                    handler(mob, target, optParams)
                end

                runSpecialMobHook(zoneName, mobName, eventName, modelSize, mob, target, optParams)
            end)
        end
    end
end

-- Register all mob overrides from the mobNames table
for zoneName, mobs in pairs(mobNames) do
    if mobs then
        for _, mobEntry in ipairs(mobs) do
            local mobName         = mobEntry[1]
            local overrideMobType = mobEntry[2]
            local modelSize       = mobEntry[3]
            registerMobOverrides(zoneName, mobName, overrideMobType, modelSize)
        end
    end
end

-----------------------------------
-- Hourglass and Currency Vendor Overrides (Lootblox, Antiqix, Haggleblix)
-- Era sells the Timeless Hourglass item instead of the Prismatic Hourglass key item, and there is no refund
-- This is more or less a hack in one place for the trigger messaging for asking about hourglasses but everything else should work
-----------------------------------
m:addOverride('xi.dynamis.hourglassAndCurrencyExchangeNPCOnTrade', function(player, npc, trade)
    local gil       = trade:getGil()
    local count     = trade:getItemCount()
    local tradeItem = trade:getItemId(0)

    local zoneId   = player:getZoneID()
    local baseCs   = xi.dynamis.hourglassAndCurrencyExchangeNPCLookup[zoneId].baseCs
    local currency = xi.dynamis.hourglassAndCurrencyExchangeNPCLookup[zoneId].currency
    local shop     = xi.dynamis.hourglassAndCurrencyExchangeNPCLookup[zoneId].shop

    -- Zero this out, just in case
    player:setLocalVar('currencyExchange', 0)

    if player:hasKeyItem(xi.keyItem.VIAL_OF_SHROUDED_SAND) then
        -- buy timeless hourglass
        if
            gil == xi.dynamis.settings.TIMELESS_HOURGLASS_COST and
            count == 1 and
            not player:hasItem(xi.item.TIMELESS_HOURGLASS)
        then
            player:startEvent(baseCs + 4, xi.item.TIMELESS_HOURGLASS)

        -- currency exchanges
        elseif -- 1's -> 100's
            count == xi.settings.main.CURRENCY_EXCHANGE_RATE and
            trade:hasItemQty(currency[1], xi.settings.main.CURRENCY_EXCHANGE_RATE)
        then
            player:startEvent(baseCs + 5, xi.settings.main.CURRENCY_EXCHANGE_RATE)
        elseif -- 100's -> 10'000's
            count == xi.settings.main.CURRENCY_EXCHANGE_RATE and
            trade:hasItemQty(currency[2], xi.settings.main.CURRENCY_EXCHANGE_RATE)
        then
            player:startEvent(baseCs + 6, xi.settings.main.CURRENCY_EXCHANGE_RATE)
        elseif -- 10'000's to 100's
            count == 1 and
            trade:hasItemQty(currency[3], 1) and
            tradeItem == currency[3]
        then
            player:setLocalVar('currencyExchange', currency[2])
            player:startEvent(baseCs + 8, tradeItem, currency[2], xi.settings.main.CURRENCY_EXCHANGE_RATE)
        elseif -- (optional) 100's to 1's
            xi.settings.main.ENABLE_EXCHANGE_100S_TO_1S and
            count == 1 and
            trade:hasItemQty(currency[2], 1) and
            tradeItem == currency[2]
        then
            player:setLocalVar('currencyExchange', currency[1])
            player:startEvent(baseCs + 8, tradeItem, currency[1], xi.settings.main.CURRENCY_EXCHANGE_RATE)

        -- shop
        else
            local item
            local price
            for i = 1, 13, 2 do
                price = shop[i]
                item = shop[i + 1]
                if count == price and trade:hasItemQty(currency[2], price) then
                    player:setLocalVar('hundredItemBought', item)
                    player:startEvent(baseCs + 7, currency[2], price, item)
                    break
                end
            end
        end
    end
end)

m:addOverride('xi.dynamis.hourglassAndCurrencyExchangeNPCOnTrigger', function(player, npc)
    local zoneId   = player:getZoneID()
    local baseCs   = xi.dynamis.hourglassAndCurrencyExchangeNPCLookup[zoneId].baseCs
    local currency = xi.dynamis.hourglassAndCurrencyExchangeNPCLookup[zoneId].currency

    if player:hasKeyItem(xi.keyItem.VIAL_OF_SHROUDED_SAND) then
        player:startEvent(baseCs + 3, currency[1], xi.settings.main.CURRENCY_EXCHANGE_RATE, currency[2], xi.settings.main.CURRENCY_EXCHANGE_RATE, currency[3], xi.dynamis.settings.TIMELESS_HOURGLASS_COST, xi.item.TIMELESS_HOURGLASS, xi.dynamis.settings.TIMELESS_HOURGLASS_COST)
    else
        player:startEvent(baseCs + 0)
    end
end)

m:addOverride('xi.dynamis.hourglassAndCurrencyExchangeNPCOnEventUpdate', function(player, csid, option, npc)
    local zoneId   = player:getZoneID()
    local ID       = zones[zoneId]
    local baseCs   = xi.dynamis.hourglassAndCurrencyExchangeNPCLookup[zoneId].baseCs
    local currency = xi.dynamis.hourglassAndCurrencyExchangeNPCLookup[zoneId].currency
    local shop     = xi.dynamis.hourglassAndCurrencyExchangeNPCLookup[zoneId].shop

    if csid == baseCs + 3 then
        -- asking about hourglasses: the client event pitches the Prismatic Hourglass KI, so end it and say the era lines instead
        -- this is the hack to make the lines show up
        if option == 1 then
            player:release()

            local npcName = npc:getPacketName()
            player:printToPlayer('Ya know, if ya really want a Timeless Hourglass, I could sell one to ya for the right price.', xi.msg.channel.NS_SAY, npcName)
            player:printToPlayer(string.format('%d gil, and not a single gil less! Ya got a problem with that, kid?', xi.dynamis.settings.TIMELESS_HOURGLASS_COST), xi.msg.channel.NS_SAY, npcName)
            player:printToPlayer("So if ya want one, stop dawdlin' around already and hand me over some money.", xi.msg.channel.NS_SAY, npcName)

        -- shop
        elseif option == 2 then
            player:updateEvent(unpack(shop, 1, 8))
        elseif option == 3 then
            player:updateEvent(unpack(shop, 9, 14))

        -- offer to trade down from a 10k
        elseif option == 10 then
            player:updateEvent(currency[3], currency[2], xi.settings.main.CURRENCY_EXCHANGE_RATE)

        -- main menu (param1 = dynamis map bitmask, param2 = gil)
        elseif option == 11 then
            player:updateEvent(xi.dynamis.getDynamisMapList(player), player:getGil())

        -- maps
        elseif xi.dynamis.mapShopCosts[option] ~= nil then
            local price = xi.dynamis.mapShopCosts[option]
            if price > player:getGil() then
                player:messageSpecial(ID.text.NOT_ENOUGH_GIL)
            else
                player:delGil(price)
                npcUtil.giveKeyItem(player, option)
            end

            player:updateEvent(xi.dynamis.getDynamisMapList(player), player:getGil())
        end
    end
end)

m:addOverride('xi.dynamis.hourglassAndCurrencyExchangeNPCOnEventFinish', function(player, csid, option, npc)
    local zoneId   = player:getZoneID()
    local ID       = zones[zoneId]
    local baseCs   = xi.dynamis.hourglassAndCurrencyExchangeNPCLookup[zoneId].baseCs
    local currency = xi.dynamis.hourglassAndCurrencyExchangeNPCLookup[zoneId].currency

    -- bought timeless hourglass
    if csid == baseCs + 4 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.TIMELESS_HOURGLASS)
        else
            player:tradeComplete()
            player:addItem(xi.item.TIMELESS_HOURGLASS)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.TIMELESS_HOURGLASS)
        end

    -- singles to hundreds
    elseif csid == baseCs + 5 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, currency[2])
        else
            player:tradeComplete()
            player:addItem(currency[2])
            player:messageSpecial(ID.text.ITEM_OBTAINED, currency[2])
        end

    -- hundreds to 10k pieces
    elseif csid == baseCs + 6 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, currency[3])
        else
            player:tradeComplete()
            player:addItem(currency[3])
            player:messageSpecial(ID.text.ITEM_OBTAINED, currency[3])
        end

    -- 10k pieces to hundreds (or hundreds to singles)
    elseif csid == baseCs + 8 then
        local currencyExchange = player:getLocalVar('currencyExchange')
        local slotsReq         = math.ceil(xi.settings.main.CURRENCY_EXCHANGE_RATE / 99)
        if player:getFreeSlotsCount() < slotsReq then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, currencyExchange)
        else
            player:tradeComplete()
            for i = 1, slotsReq do
                if i < slotsReq or (xi.settings.main.CURRENCY_EXCHANGE_RATE % 99) == 0 then
                    player:addItem(currencyExchange, 99)
                else
                    player:addItem(currencyExchange, xi.settings.main.CURRENCY_EXCHANGE_RATE % 99)
                end
            end

            player:messageSpecial(ID.text.ITEMS_OBTAINED, currencyExchange, xi.settings.main.CURRENCY_EXCHANGE_RATE)
        end

        -- Zero this out, just in case
        player:setLocalVar('currencyExchange', 0)

    -- bought item from shop
    elseif csid == baseCs + 7 then
        local item = player:getLocalVar('hundredItemBought')
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, item)
        else
            player:tradeComplete()
            player:addItem(item)
            player:messageSpecial(ID.text.ITEM_OBTAINED, item)
        end

        player:setLocalVar('hundredItemBought', 0)
    end
end)
