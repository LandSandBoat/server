------------------------------------
require("scripts/globals/missions")
require("scripts/globals/status")
------------------------------------

tpz = tpz or {}
tpz.rhapsodies = tpz.rhapsodies or {}

tpz.rhapsodies.character = {
    PRISHE     = 0,
    TENZEN     = 1,
    APHMAU     = 2,
    LILLISETTE = 3,
    CAIT_SITH  = 4,
    ARCIELA    = 5,
}

tpz.rhapsodies.expansion =
{
    [tpz.rhapsodies.character.PRISHE]     = COP,
    [tpz.rhapsodies.character.TENZEN]     = COP,
    [tpz.rhapsodies.character.APHMAU]     = TOAU,
    [tpz.rhapsodies.character.LILLISETTE] = WOTG,
    [tpz.rhapsodies.character.CAIT_SITH]  = WOTG,
    [tpz.rhapsodies.character.ARCIELA]    = SOA,
}

-- ALERT, TODO, NOTE: To be removed when set constructor makes it into master!
local set = function(list)
    local set = {}
    for _, item in pairs(list) do
        set[item] = true
    end
    return set
end

tpz.rhapsodies.unavailability =
{
    [tpz.rhapsodies.character.PRISHE] = set{
       tpz.mission.id.cop.DARKNESS_NAMED,
       tpz.mission.id.cop.SLANDEROUS_UTTERINGS,
       tpz.mission.id.cop.DESIRES_OF_EMPTINESS,
       tpz.mission.id.cop.THREE_PATHS,
       tpz.mission.id.cop.FOR_WHOM_THE_VERSE_IS_SUNG,
       tpz.mission.id.cop.A_PLACE_TO_RETURN,
       tpz.mission.id.cop.MORE_QUESTIONS_THAN_ANSWERS,
       tpz.mission.id.cop.ONE_TO_BE_FEARED,
       tpz.mission.id.cop.THE_WARRIOR_S_PATH,
       tpz.mission.id.cop.GARDEN_OF_ANTIQUITY,
       tpz.mission.id.cop.WHEN_ANGELS_FALL,
       tpz.mission.id.cop.DAWN,
    },
    [tpz.rhapsodies.character.TENZEN] = set{
        tpz.mission.id.cop.THE_CALL_OF_THE_WYRMKING,
        tpz.mission.id.cop.A_VESSEL_WITHOUT_A_CAPTAIN,
        tpz.mission.id.cop.DESIRES_OF_EMPTINESS,
        tpz.mission.id.cop.THE_WARRIOR_S_PATH,
        tpz.mission.id.cop.GARDEN_OF_ANTIQUITY,
        tpz.mission.id.cop.WHEN_ANGELS_FALL,
        tpz.mission.id.cop.DAWN,
    },
    [tpz.rhapsodies.character.APHMAU] = set{
        tpz.mission.id.toau.LAND_OF_SACRED_SERPENTS,
        tpz.mission.id.toau.IMMORTAL_SENTRIES,
        tpz.mission.id.toau.PRESIDENT_SALAHEEM,
        tpz.mission.id.toau.KNIGHT_OF_GOLD,
        tpz.mission.id.toau.CONFESSIONS_OF_ROYALTY,
        tpz.mission.id.toau.EASTERLY_WINDS,
        tpz.mission.id.toau.WESTERLY_WINDS,
        tpz.mission.id.toau.A_MERCENARY_LIFE,
        tpz.mission.id.toau.UNDERSEA_SCOUTING,
        tpz.mission.id.toau.ASTRAL_WAVES,
        tpz.mission.id.toau.IMPERIAL_SCHEMES,
        tpz.mission.id.toau.SWEETS_FOR_THE_SOUL,
        tpz.mission.id.toau.TEAHOUSE_TUMULT,
        tpz.mission.id.toau.FINDERS_KEEPERS,
        tpz.mission.id.toau.SEAL_OF_THE_SERPENT,
        tpz.mission.id.toau.MISPLACED_NOBILITY,
        tpz.mission.id.toau.BASTION_OF_KNOWLEDGE,
        tpz.mission.id.toau.PUPPET_IN_PERIL,
        tpz.mission.id.toau.PREVALENCE_OF_PIRATES,
        tpz.mission.id.toau.SHADES_OF_VENGEANCE,
        tpz.mission.id.toau.IN_THE_BLOOD,
        tpz.mission.id.toau.SENTINELS_HONOR,
        tpz.mission.id.toau.TESTING_THE_WATERS,
        tpz.mission.id.toau.LEGACY_OF_THE_LOST,
        tpz.mission.id.toau.GAZE_OF_THE_SABOTEUR,
        tpz.mission.id.toau.PATH_OF_BLOOD,
        tpz.mission.id.toau.STIRRINGS_OF_WAR,
        tpz.mission.id.toau.ALLIED_RUMBLINGS,
        tpz.mission.id.toau.UNRAVELING_REASON,
        tpz.mission.id.toau.LIGHT_OF_JUDGMENT,
        tpz.mission.id.toau.PATH_OF_DARKNESS,
        tpz.mission.id.toau.FANGS_OF_THE_LION,
        tpz.mission.id.toau.NASHMEIRAS_PLEA,
        tpz.mission.id.toau.RAGNAROK,
        tpz.mission.id.toau.IMPERIAL_CORONATION,
    },
    [tpz.rhapsodies.character.LILLISETTE] = set{
        tpz.mission.id.wotg.CAVERNOUS_MAWS,
        tpz.mission.id.wotg.BACK_TO_THE_BEGINNING,
        tpz.mission.id.wotg.CAIT_SITH,
        tpz.mission.id.wotg.THE_QUEEN_OF_THE_DANCE,
        tpz.mission.id.wotg.WHILE_THE_CAT_IS_AWAY,
        tpz.mission.id.wotg.ON_THIN_ICE,
        tpz.mission.id.wotg.PROOF_OF_VALOR,
        tpz.mission.id.wotg.A_SANGUINARY_PRELUDE,
        tpz.mission.id.wotg.DUNGEONS_AND_DANCERS,
        tpz.mission.id.wotg.DISTORTER_OF_TIME,
        tpz.mission.id.wotg.THE_WILL_OF_THE_WORLD,
        tpz.mission.id.wotg.ADIEU__LILISETTE,
        tpz.mission.id.wotg.BY_THE_FADING_LIGHT,
        tpz.mission.id.wotg.EDGE_OF_EXISTENCE,
        tpz.mission.id.wotg.HER_MEMORIES,
        tpz.mission.id.wotg.FORGET_ME_NOT,
        tpz.mission.id.wotg.PILLAR_OF_HOPE,
        tpz.mission.id.wotg.GLIMMER_OF_LIFE,
        tpz.mission.id.wotg.TIME_SLIPS_AWAY,
        tpz.mission.id.wotg.WHEN_WILLS_COLLIDE,
        tpz.mission.id.wotg.WHISPERS_OF_DAWN,
        tpz.mission.id.wotg.WHERE_IT_ALL_BEGAN,
        tpz.mission.id.wotg.A_TOKEN_OF_TROTH,
        tpz.mission.id.wotg.LEST_WE_FORGET,
    },
    [tpz.rhapsodies.character.CAIT_SITH] = set{
        tpz.mission.id.wotg.CAVERNOUS_MAWS,
        tpz.mission.id.wotg.BACK_TO_THE_BEGINNING,
        tpz.mission.id.wotg.WHERE_IT_ALL_BEGAN,
        tpz.mission.id.wotg.A_TOKEN_OF_TROTH,
        tpz.mission.id.wotg.LEST_WE_FORGET,
    },
    [tpz.rhapsodies.character.ARCIELA] = set{
        tpz.mission.id.soa.RUMORS_FROM_THE_WEST,
        tpz.mission.id.soa.THE_GEOMAGNETRON,
        tpz.mission.id.soa.ONWARD_TO_ADOULIN,
        tpz.mission.id.soa.HEARTWINGS_AND_THE_KINDHEARTED,
        tpz.mission.id.soa.PIONEER_REGISTRATION,
        tpz.mission.id.soa.LIFE_ON_THE_FRONTIER,
        tpz.mission.id.soa.MEETING_OF_THE_MINDS,
        tpz.mission.id.soa.ARCIELA_APPEARS_AGAIN,
        tpz.mission.id.soa.BUILDING_PROSPECTS,
        tpz.mission.id.soa.THE_LIGHT_SHINING_IN_YOUR_EYES,
        tpz.mission.id.soa.THE_HEIRLOOM,
        tpz.mission.id.soa.AN_AIMLESS_JOURNEY,
        tpz.mission.id.soa.THE_ORDERS_TREASURES,
        tpz.mission.id.soa.AUGUSTS_HEIRLOOM,
        tpz.mission.id.soa.BEAUTY_AND_THE_BEAST,
        tpz.mission.id.soa.WILDCAT_WITH_A_GOLD_PELT,
        tpz.mission.id.soa.IN_SEARCH_OF_ARCIELA,
        tpz.mission.id.soa.LOOKING_FOR_LEADS,
        tpz.mission.id.soa.DRIFTING_NORTHWEST,
        tpz.mission.id.soa.KUMHAU_THE_FLASHFROST_NAAKUAL,
        tpz.mission.id.soa.SOUL_SIPHON,
        tpz.mission.id.soa.STONEWALLED,
        tpz.mission.id.soa.SALVATION,
        tpz.mission.id.soa.BALAMOR_THE_DEATHBORNE_XOL,
        tpz.mission.id.soa.ANAGNORISIS,
        tpz.mission.id.soa.JUST_THE_THING,
        tpz.mission.id.soa.SUGARCOATED_SALVATION,
        tpz.mission.id.soa.RECKONING,
        tpz.mission.id.soa.ABOMINATION,
        tpz.mission.id.soa.UNDYING_LIGHT,
        tpz.mission.id.soa.THE_LIGHT_WITHIN,
    },
}

tpz.rhapsodies.requiredCharacters =
{
    [tpz.mission.id.rov.RING_MY_BELL] = {
        tpz.rhapsodies.character.TENZEN,
    },
    [tpz.mission.id.rov.SPIRITS_AWOKEN] = {
        tpz.rhapsodies.character.TENZEN,
    },
    [tpz.mission.id.rov.CRASHING_WAVES] = {
        tpz.rhapsodies.character.TENZEN,
    },
    [tpz.mission.id.rov.CALL_TO_SERVE] = {
        tpz.rhapsodies.character.TENZEN,
    },
    [tpz.mission.id.rov.NUMBERING_DAYS] = {
        tpz.rhapsodies.character.TENZEN,
        tpz.rhapsodies.character.PRISHE,
    },
    [tpz.mission.id.rov.INESCAPABLE_BINDS] = {
        tpz.rhapsodies.character.TENZEN,
        tpz.rhapsodies.character.PRISHE,
    },
    [tpz.mission.id.rov.EVER_FORWARD] = {
        tpz.rhapsodies.character.PRISHE,
    },
    [tpz.mission.id.rov.REUNITED] = {
        tpz.rhapsodies.character.APHMAU,
    },
    [tpz.mission.id.rov.TAKE_WING] = {
        tpz.rhapsodies.character.TENZEN,
        tpz.rhapsodies.character.APHMAU,
    },
    [tpz.mission.id.rov.PRIME_NUMBER] = {
        tpz.rhapsodies.character.TENZEN,
        tpz.rhapsodies.character.APHMAU,
    },
    [tpz.mission.id.rov.FROM_THE_RUINS] = {
        tpz.rhapsodies.character.TENZEN,
        tpz.rhapsodies.character.APHMAU,
    },
    [tpz.mission.id.rov.CAUTERIZE] = {
        tpz.rhapsodies.character.APHMAU,
    },
    [tpz.mission.id.rov.UNCERTAIN_DESTINATIONS] = {
        tpz.rhapsodies.character.CAIT_SITH,
    },
    [tpz.mission.id.rov.GANGED_UP_ON] = {
        tpz.rhapsodies.character.CAIT_SITH,
    },
    [tpz.mission.id.rov.SACRIFICE] = {
        tpz.rhapsodies.character.LILLISETTE,
        tpz.rhapsodies.character.CAIT_SITH,
    },
    [tpz.mission.id.rov.SOMBER_DREAMS] = {
        tpz.rhapsodies.character.LILLISETTE,
        tpz.rhapsodies.character.CAIT_SITH,
    },
    [tpz.mission.id.rov.OF_LIGHT_AND_DARKNESS] = {
        tpz.rhapsodies.character.LILLISETTE,
        tpz.rhapsodies.character.CAIT_SITH,
    },
    [tpz.mission.id.rov.THE_CURSED_TEMPLE] = {
        tpz.rhapsodies.character.TENZEN,
    },
    [tpz.mission.id.rov.WISDOM_OF_OUR_FOREFATHERS] = {
        tpz.rhapsodies.character.TENZEN,
    },
    [tpz.mission.id.rov.WHERE_DIVINITIES_COLLIDE] = {
        tpz.rhapsodies.character.TENZEN,
    },
    [tpz.mission.id.rov.VISIONS_OF_DREAD] = {
        tpz.rhapsodies.character.TENZEN,
    },
    [tpz.mission.id.rov.TO_THE_SKIES] = {
        tpz.rhapsodies.character.TENZEN,
    },
    [tpz.mission.id.rov.ESCHA_RUAUN] = {
        tpz.rhapsodies.character.TENZEN,
    },
    [tpz.mission.id.rov.THE_DECISIVE_HEROINE] = {
        tpz.rhapsodies.character.TENZEN,
    },
    [tpz.mission.id.rov.FALL_FROM_GRACE] = {
        tpz.rhapsodies.character.TENZEN,
    },
    [tpz.mission.id.rov.OVER_THE_RAINBOW] = {
        tpz.rhapsodies.character.TENZEN,
    },
    [tpz.mission.id.rov.CACOPHONOUS_DISCORD] = {
        tpz.rhapsodies.character.TENZEN,
    },
    [tpz.mission.id.rov.CALL_OF_THE_VOID] = {
        tpz.rhapsodies.character.TENZEN,
    },
    [tpz.mission.id.rov.WHAT_REMAINS_OF_HOPE] = {
        tpz.rhapsodies.character.ARCIELA,
    },
    [tpz.mission.id.rov.DEATH_CARES_NOT] = {
        tpz.rhapsodies.character.ARCIELA,
    },
    [tpz.mission.id.rov.NO_TIME_LIKE_THE_FUTURE] = {
        tpz.rhapsodies.character.ARCIELA,
    },
    [tpz.mission.id.rov.SIN] = {
        tpz.rhapsodies.character.ARCIELA,
    },
    [tpz.mission.id.rov.FROM_WEST_TO_EAST] = {
        tpz.rhapsodies.character.TENZEN,
    },
    [tpz.mission.id.rov.GOOD_THINGS_COME_IN_THREES] = {
        tpz.rhapsodies.character.TENZEN,
    },
    [tpz.mission.id.rov.TACKLING_THE_PROBLEM] = {
        tpz.rhapsodies.character.TENZEN,
    },
    [tpz.mission.id.rov.WAY_TO_DIVINITY] = {
        tpz.rhapsodies.character.TENZEN,
    },
    [tpz.mission.id.rov.NARY_A_CLOUD_IN_SIGHT] = {
        tpz.rhapsodies.character.TENZEN,
    },
    [tpz.mission.id.rov.AN_UNENDING_SONG] = {
        tpz.rhapsodies.character.TENZEN,
    },
    [tpz.mission.id.rov.GUARDIANS] = {
        tpz.rhapsodies.character.TENZEN,
    },
    [tpz.mission.id.rov.IROHA_IN_DISTRESS] = {
        tpz.rhapsodies.character.TENZEN,
    },
    [tpz.mission.id.rov.ABSOLUTE_TRUST] = {
        tpz.rhapsodies.character.TENZEN,
    },
}

------------------------------------
-- PUBLIC FUNCTIONS
------------------------------------
-- Lockout Table:
-- http://forum.square-enix.com/ffxi/threads/47983-What-should-I-do-if-I-can%E2%80%99t-progress-in-Rhapsodies-of-Vana%E2%80%99diel

tpz.rhapsodies.charactersAvailable = function(player)
    local rov_mission = player:getCurrentMission(ROV)
    for _, char in pairs(tpz.rhapsodies.requiredCharacters[rov_mission]) do
        local expansion_mission = player:getCurrentMission(tpz.rhapsodies.expansion[char])
        if tpz.rhapsodies.unavailability[char][expansion_mission] then
            return false
        end
    end
    return true
end
