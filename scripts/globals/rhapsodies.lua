-----------------------------------
require('scripts/globals/missions')
-----------------------------------
xi = xi or {}
xi.rhapsodies = xi.rhapsodies or {}

xi.rhapsodies.character =
{
    PRISHE     = 0,
    TENZEN     = 1,
    APHMAU     = 2,
    LILLISETTE = 3,
    CAIT_SITH  = 4,
    ARCIELA    = 5,
}

xi.rhapsodies.expansion =
{
    [xi.rhapsodies.character.PRISHE]     = xi.mission.log_id.COP,
    [xi.rhapsodies.character.TENZEN]     = xi.mission.log_id.COP,
    [xi.rhapsodies.character.APHMAU]     = xi.mission.log_id.TOAU,
    [xi.rhapsodies.character.LILLISETTE] = xi.mission.log_id.WOTG,
    [xi.rhapsodies.character.CAIT_SITH]  = xi.mission.log_id.WOTG,
    [xi.rhapsodies.character.ARCIELA]    = xi.mission.log_id.SOA,
}

xi.rhapsodies.unavailability =
{
    [xi.rhapsodies.character.PRISHE] = set{
        xi.mission.id.cop.DARKNESS_NAMED,
        xi.mission.id.cop.SLANDEROUS_UTTERINGS,
        xi.mission.id.cop.DESIRES_OF_EMPTINESS,
        xi.mission.id.cop.THREE_PATHS,
        xi.mission.id.cop.FOR_WHOM_THE_VERSE_IS_SUNG,
        xi.mission.id.cop.A_PLACE_TO_RETURN,
        xi.mission.id.cop.MORE_QUESTIONS_THAN_ANSWERS,
        xi.mission.id.cop.ONE_TO_BE_FEARED,
        xi.mission.id.cop.THE_WARRIORS_PATH,
        xi.mission.id.cop.GARDEN_OF_ANTIQUITY,
        xi.mission.id.cop.WHEN_ANGELS_FALL,
        xi.mission.id.cop.DAWN,
    },
    [xi.rhapsodies.character.TENZEN] = set{
        xi.mission.id.cop.THE_CALL_OF_THE_WYRMKING,
        xi.mission.id.cop.A_VESSEL_WITHOUT_A_CAPTAIN,
        xi.mission.id.cop.DESIRES_OF_EMPTINESS,
        xi.mission.id.cop.THE_WARRIORS_PATH,
        xi.mission.id.cop.GARDEN_OF_ANTIQUITY,
        xi.mission.id.cop.WHEN_ANGELS_FALL,
        xi.mission.id.cop.DAWN,
    },
    [xi.rhapsodies.character.APHMAU] = set{
        xi.mission.id.toau.LAND_OF_SACRED_SERPENTS,
        xi.mission.id.toau.IMMORTAL_SENTRIES,
        xi.mission.id.toau.PRESIDENT_SALAHEEM,
        xi.mission.id.toau.KNIGHT_OF_GOLD,
        xi.mission.id.toau.CONFESSIONS_OF_ROYALTY,
        xi.mission.id.toau.EASTERLY_WINDS,
        xi.mission.id.toau.WESTERLY_WINDS,
        xi.mission.id.toau.A_MERCENARY_LIFE,
        xi.mission.id.toau.UNDERSEA_SCOUTING,
        xi.mission.id.toau.ASTRAL_WAVES,
        xi.mission.id.toau.IMPERIAL_SCHEMES,
        xi.mission.id.toau.SWEETS_FOR_THE_SOUL,
        xi.mission.id.toau.TEAHOUSE_TUMULT,
        xi.mission.id.toau.FINDERS_KEEPERS,
        xi.mission.id.toau.SEAL_OF_THE_SERPENT,
        xi.mission.id.toau.MISPLACED_NOBILITY,
        xi.mission.id.toau.BASTION_OF_KNOWLEDGE,
        xi.mission.id.toau.PUPPET_IN_PERIL,
        xi.mission.id.toau.PREVALENCE_OF_PIRATES,
        xi.mission.id.toau.SHADES_OF_VENGEANCE,
        xi.mission.id.toau.IN_THE_BLOOD,
        xi.mission.id.toau.SENTINELS_HONOR,
        xi.mission.id.toau.TESTING_THE_WATERS,
        xi.mission.id.toau.LEGACY_OF_THE_LOST,
        xi.mission.id.toau.GAZE_OF_THE_SABOTEUR,
        xi.mission.id.toau.PATH_OF_BLOOD,
        xi.mission.id.toau.STIRRINGS_OF_WAR,
        xi.mission.id.toau.ALLIED_RUMBLINGS,
        xi.mission.id.toau.UNRAVELING_REASON,
        xi.mission.id.toau.LIGHT_OF_JUDGMENT,
        xi.mission.id.toau.PATH_OF_DARKNESS,
        xi.mission.id.toau.FANGS_OF_THE_LION,
        xi.mission.id.toau.NASHMEIRAS_PLEA,
        xi.mission.id.toau.RAGNAROK,
        xi.mission.id.toau.IMPERIAL_CORONATION,
    },
    [xi.rhapsodies.character.LILLISETTE] = set{
        xi.mission.id.wotg.CAVERNOUS_MAWS,
        xi.mission.id.wotg.BACK_TO_THE_BEGINNING,
        xi.mission.id.wotg.CAIT_SITH,
        xi.mission.id.wotg.THE_QUEEN_OF_THE_DANCE,
        xi.mission.id.wotg.WHILE_THE_CAT_IS_AWAY,
        xi.mission.id.wotg.ON_THIN_ICE,
        xi.mission.id.wotg.PROOF_OF_VALOR,
        xi.mission.id.wotg.A_SANGUINARY_PRELUDE,
        xi.mission.id.wotg.DUNGEONS_AND_DANCERS,
        xi.mission.id.wotg.DISTORTER_OF_TIME,
        xi.mission.id.wotg.THE_WILL_OF_THE_WORLD,
        xi.mission.id.wotg.ADIEU_LILISETTE,
        xi.mission.id.wotg.BY_THE_FADING_LIGHT,
        xi.mission.id.wotg.EDGE_OF_EXISTENCE,
        xi.mission.id.wotg.HER_MEMORIES,
        xi.mission.id.wotg.FORGET_ME_NOT,
        xi.mission.id.wotg.PILLAR_OF_HOPE,
        xi.mission.id.wotg.GLIMMER_OF_LIFE,
        xi.mission.id.wotg.TIME_SLIPS_AWAY,
        xi.mission.id.wotg.WHEN_WILLS_COLLIDE,
        xi.mission.id.wotg.WHISPERS_OF_DAWN,
        xi.mission.id.wotg.WHERE_IT_ALL_BEGAN,
        xi.mission.id.wotg.A_TOKEN_OF_TROTH,
        xi.mission.id.wotg.LEST_WE_FORGET,
    },
    [xi.rhapsodies.character.CAIT_SITH] = set{
        xi.mission.id.wotg.CAVERNOUS_MAWS,
        xi.mission.id.wotg.BACK_TO_THE_BEGINNING,
        xi.mission.id.wotg.WHERE_IT_ALL_BEGAN,
        xi.mission.id.wotg.A_TOKEN_OF_TROTH,
        xi.mission.id.wotg.LEST_WE_FORGET,
    },
    [xi.rhapsodies.character.ARCIELA] = set{
        xi.mission.id.soa.RUMORS_FROM_THE_WEST,
        xi.mission.id.soa.THE_GEOMAGNETRON,
        xi.mission.id.soa.ONWARD_TO_ADOULIN,
        xi.mission.id.soa.HEARTWINGS_AND_THE_KINDHEARTED,
        xi.mission.id.soa.PIONEER_REGISTRATION,
        xi.mission.id.soa.LIFE_ON_THE_FRONTIER,
        xi.mission.id.soa.MEETING_OF_THE_MINDS,
        xi.mission.id.soa.ARCIELA_APPEARS_AGAIN,
        xi.mission.id.soa.BUILDING_PROSPECTS,
        xi.mission.id.soa.THE_LIGHT_SHINING_IN_YOUR_EYES,
        xi.mission.id.soa.THE_HEIRLOOM,
        xi.mission.id.soa.AN_AIMLESS_JOURNEY,
        xi.mission.id.soa.THE_ORDERS_TREASURES,
        xi.mission.id.soa.AUGUSTS_HEIRLOOM,
        xi.mission.id.soa.BEAUTY_AND_THE_BEAST,
        xi.mission.id.soa.WILDCAT_WITH_A_GOLD_PELT,
        xi.mission.id.soa.IN_SEARCH_OF_ARCIELA,
        xi.mission.id.soa.LOOKING_FOR_LEADS,
        xi.mission.id.soa.DRIFTING_NORTHWEST,
        xi.mission.id.soa.KUMHAU_THE_FLASHFROST_NAAKUAL,
        xi.mission.id.soa.SOUL_SIPHON,
        xi.mission.id.soa.STONEWALLED,
        xi.mission.id.soa.SALVATION,
        xi.mission.id.soa.BALAMOR_THE_DEATHBORNE_XOL,
        xi.mission.id.soa.ANAGNORISIS,
        xi.mission.id.soa.JUST_THE_THING,
        xi.mission.id.soa.SUGARCOATED_SALVATION,
        xi.mission.id.soa.RECKONING,
        xi.mission.id.soa.ABOMINATION,
        xi.mission.id.soa.UNDYING_LIGHT,
        xi.mission.id.soa.THE_LIGHT_WITHIN,
    },
}

xi.rhapsodies.requiredCharacters =
{
    [xi.mission.id.rov.RING_MY_BELL] =
    {
        xi.rhapsodies.character.TENZEN,
    },

    [xi.mission.id.rov.SPIRITS_AWOKEN] =
    {
        xi.rhapsodies.character.TENZEN,
    },

    [xi.mission.id.rov.CRASHING_WAVES] =
    {
        xi.rhapsodies.character.TENZEN,
    },

    [xi.mission.id.rov.CALL_TO_SERVE] =
    {
        xi.rhapsodies.character.TENZEN,
    },

    [xi.mission.id.rov.NUMBERING_DAYS] =
    {
        xi.rhapsodies.character.TENZEN,
        xi.rhapsodies.character.PRISHE,
    },

    [xi.mission.id.rov.INESCAPABLE_BINDS] =
    {
        xi.rhapsodies.character.TENZEN,
        xi.rhapsodies.character.PRISHE,
    },

    [xi.mission.id.rov.EVER_FORWARD] =
    {
        xi.rhapsodies.character.PRISHE,
    },

    [xi.mission.id.rov.REUNITED] =
    {
        xi.rhapsodies.character.APHMAU,
    },

    [xi.mission.id.rov.TAKE_WING] =
    {
        xi.rhapsodies.character.TENZEN,
        xi.rhapsodies.character.APHMAU,
    },

    [xi.mission.id.rov.PRIME_NUMBER] =
    {
        xi.rhapsodies.character.TENZEN,
        xi.rhapsodies.character.APHMAU,
    },

    [xi.mission.id.rov.FROM_THE_RUINS] =
    {
        xi.rhapsodies.character.TENZEN,
        xi.rhapsodies.character.APHMAU,
    },

    [xi.mission.id.rov.CAUTERIZE] =
    {
        xi.rhapsodies.character.CAIT_SITH,
    },

    [xi.mission.id.rov.UNCERTAIN_DESTINATIONS] =
    {
        xi.rhapsodies.character.CAIT_SITH,
    },

    [xi.mission.id.rov.GANGED_UP_ON] =
    {
        xi.rhapsodies.character.LILLISETTE,
    },

    [xi.mission.id.rov.SACRIFICE] =
    {
        xi.rhapsodies.character.LILLISETTE,
        xi.rhapsodies.character.CAIT_SITH,
    },

    [xi.mission.id.rov.SOMBER_DREAMS] =
    {
        xi.rhapsodies.character.LILLISETTE,
        xi.rhapsodies.character.CAIT_SITH,
    },

    [xi.mission.id.rov.OF_LIGHT_AND_DARKNESS] =
    {
        xi.rhapsodies.character.LILLISETTE,
        xi.rhapsodies.character.CAIT_SITH,
    },

    [xi.mission.id.rov.PAST_IMPERFECT] =
    {
        xi.rhapsodies.character.TENZEN,
    },

    [xi.mission.id.rov.THE_CURSED_TEMPLE] =
    {
        xi.rhapsodies.character.TENZEN,
    },

    [xi.mission.id.rov.WISDOM_OF_OUR_FOREFATHERS] =
    {
        xi.rhapsodies.character.TENZEN,
    },

    [xi.mission.id.rov.WHERE_DIVINITIES_COLLIDE] =
    {
        xi.rhapsodies.character.TENZEN,
    },

    [xi.mission.id.rov.VISIONS_OF_DREAD] =
    {
        xi.rhapsodies.character.TENZEN,
    },

    [xi.mission.id.rov.TO_THE_SKIES] =
    {
        xi.rhapsodies.character.TENZEN,
    },

    [xi.mission.id.rov.ESCHA_RUAUN] =
    {
        xi.rhapsodies.character.TENZEN,
    },

    [xi.mission.id.rov.THE_DECISIVE_HEROINE] =
    {
        xi.rhapsodies.character.TENZEN,
    },

    [xi.mission.id.rov.FALL_FROM_GRACE] =
    {
        xi.rhapsodies.character.TENZEN,
    },

    [xi.mission.id.rov.OVER_THE_RAINBOW] =
    {
        xi.rhapsodies.character.TENZEN,
    },

    [xi.mission.id.rov.CACOPHONOUS_DISCORD] =
    {
        xi.rhapsodies.character.TENZEN,
    },

    [xi.mission.id.rov.CALL_OF_THE_VOID] =
    {
        xi.rhapsodies.character.TENZEN,
    },

    [xi.mission.id.rov.WHAT_REMAINS_OF_HOPE] =
    {
        xi.rhapsodies.character.ARCIELA,
    },

    [xi.mission.id.rov.DEATH_CARES_NOT] =
    {
        xi.rhapsodies.character.ARCIELA,
    },

    [xi.mission.id.rov.NO_TIME_LIKE_THE_FUTURE] =
    {
        xi.rhapsodies.character.ARCIELA,
    },

    [xi.mission.id.rov.SIN] =
    {
        xi.rhapsodies.character.ARCIELA,
    },

    [xi.mission.id.rov.FROM_WEST_TO_EAST] =
    {
        xi.rhapsodies.character.TENZEN,
    },

    [xi.mission.id.rov.GOOD_THINGS_COME_IN_THREES] =
    {
        xi.rhapsodies.character.TENZEN,
    },

    [xi.mission.id.rov.TACKLING_THE_PROBLEM] =
    {
        xi.rhapsodies.character.TENZEN,
    },

    [xi.mission.id.rov.WAY_TO_DIVINITY] =
    {
        xi.rhapsodies.character.TENZEN,
    },

    [xi.mission.id.rov.NARY_A_CLOUD_IN_SIGHT] =
    {
        xi.rhapsodies.character.TENZEN,
    },

    [xi.mission.id.rov.AN_UNENDING_SONG] =
    {
        xi.rhapsodies.character.TENZEN,
    },

    [xi.mission.id.rov.GUARDIANS] =
    {
        xi.rhapsodies.character.TENZEN,
    },

    [xi.mission.id.rov.IROHA_IN_DISTRESS] =
    {
        xi.rhapsodies.character.TENZEN,
    },

    [xi.mission.id.rov.ABSOLUTE_TRUST] =
    {
        xi.rhapsodies.character.TENZEN,
    },
}

-----------------------------------
-- PUBLIC FUNCTIONS
-----------------------------------
-- Lockout Table:
-- http://forum.square-enix.com/ffxi/threads/47983-What-should-I-do-if-I-can%E2%80%99t-progress-in-Rhapsodies-of-Vana%E2%80%99diel

xi.rhapsodies.charactersAvailable = function(player)
    local rovMission = player:getCurrentMission(xi.mission.log_id.ROV)
    for _, char in pairs(xi.rhapsodies.requiredCharacters[rovMission]) do
        local expansionMission = player:getCurrentMission(xi.rhapsodies.expansion[char])
        if xi.rhapsodies.unavailability[char][expansionMission] then
            return false
        end
    end

    return true
end
