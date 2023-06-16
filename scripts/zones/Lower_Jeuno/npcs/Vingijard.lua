-----------------------------------
-- Area: Lower Jeuno
--  NPC: Vingijard
--  AF Quest Reset NPC
-----------------------------------
local entity = {}

local afQuestInfo =
{
    [xi.job.WAR] =
    {
        { xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_DOORMAN },
        { xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_TALEKEEPERS_TRUTH },
        { xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_TALEKEEPERS_GIFT },
        { xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BORGHERTZ_S_WARRING_HANDS },
    },
    [xi.job.MNK] =
    {
        { xi.quest.log_id.BASTOK, xi.quest.id.bastok.GHOSTS_OF_THE_PAST },
        { xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_FIRST_MEETING },
        { xi.quest.log_id.BASTOK, xi.quest.id.bastok.TRUE_STRENGTH },
        { xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BORGHERTZ_S_STRIKING_HANDS },
    },
    [xi.job.WHM] =
    {
        { xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.MESSENGER_FROM_BEYOND },
        { xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.PRELUDE_OF_BLACK_AND_WHITE },
        { xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.PIEUJE_S_DECISION },
        { xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BORGHERTZ_S_HEALING_HANDS },
    },
    [xi.job.BLM] =
    {
        { xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_THREE_MAGI },
        { xi.quest.log_id.WINDURST, xi.quest.id.windurst.RECOLLECTIONS },
        { xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_ROOT_OF_THE_PROBLEM },
        { xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BORGHERTZ_S_SORCEROUS_HANDS },
    },
    [xi.job.RDM] =
    {
        { xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_CRIMSON_TRIAL },
        { xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.ENVELOPED_IN_DARKNESS },
        { xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.PEACE_FOR_THE_SPIRIT },
        { xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BORGHERTZ_S_VERMILLION_HANDS },
    },
    [xi.job.THF] =
    {
        { xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_TENSHODO_SHOWDOWN },
        { xi.quest.log_id.WINDURST, xi.quest.id.windurst.AS_THICK_AS_THIEVES },
        { xi.quest.log_id.WINDURST, xi.quest.id.windurst.HITTING_THE_MARQUISATE },
        { xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BORGHERTZ_S_SNEAKY_HANDS },
    },
    [xi.job.PLD] =
    {
        { xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.SHARPENING_THE_SWORD },
        { xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_BOY_S_DREAM },
        { xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.UNDER_OATH },
        { xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BORGHERTZ_S_STALWART_HANDS },
    },
    [xi.job.DRK] =
    {
        { xi.quest.log_id.BASTOK, xi.quest.id.bastok.DARK_LEGACY },
        { xi.quest.log_id.BASTOK, xi.quest.id.bastok.DARK_PUPPET },
        { xi.quest.log_id.BASTOK, xi.quest.id.bastok.BLADE_OF_EVIL },
        { xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BORGHERTZ_S_SHADOWY_HANDS },
    },
    [xi.job.BST] =
    {
        { xi.quest.log_id.JEUNO, xi.quest.id.jeuno.WINGS_OF_GOLD },
        { xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SCATTERED_INTO_SHADOW },
        { xi.quest.log_id.JEUNO, xi.quest.id.jeuno.A_NEW_DAWN },
        { xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BORGHERTZ_S_WILD_HANDS },
    },
    [xi.job.BRD] =
    {
        { xi.quest.log_id.JEUNO, xi.quest.id.jeuno.PAINFUL_MEMORY },
        { xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_REQUIEM },
        { xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_CIRCLE_OF_TIME },
        { xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BORGHERTZ_S_HARMONIOUS_HANDS },
    },
    [xi.job.RNG] =
    {
        { xi.quest.log_id.WINDURST, xi.quest.id.windurst.SIN_HUNTING },
        { xi.quest.log_id.WINDURST, xi.quest.id.windurst.FIRE_AND_BRIMSTONE },
        { xi.quest.log_id.WINDURST, xi.quest.id.windurst.UNBRIDLED_PASSION },
        { xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BORGHERTZ_S_CHASING_HANDS },
    },
    [xi.job.SAM] =
    {
        { xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.THE_SACRED_KATANA },
        { xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.YOMI_OKURI },
        { xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.A_THIEF_IN_NORG },
        { xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BORGHERTZ_S_LOYAL_HANDS },
    },
    [xi.job.NIN] =
    {
        { xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.TWENTY_IN_PIRATE_YEARS },
        { xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.I_LL_TAKE_THE_BIG_BOX },
        { xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.TRUE_WILL },
        { xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BORGHERTZ_S_LURKING_HANDS },
    },
    [xi.job.DRG] =
    {
        { xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_CRAFTSMAN_S_WORK },
        { xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.CHASING_QUOTAS },
        { xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.KNIGHT_STALKER },
        { xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BORGHERTZ_S_DRAGON_HANDS },
    },
    [xi.job.SMN] =
    {
        { xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_PUPPET_MASTER },
        { xi.quest.log_id.WINDURST, xi.quest.id.windurst.CLASS_REUNION },
        { xi.quest.log_id.WINDURST, xi.quest.id.windurst.CARBUNCLE_DEBACLE },
        { xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BORGHERTZ_S_CALLING_HANDS },
    },
    [xi.job.BLU] =
    {
        { xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.BEGINNINGS },
        { xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.OMENS },
        { xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.TRANSFORMATIONS },
    },
    [xi.job.COR] =
    {
        { xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.EQUIPPED_FOR_ALL_OCCASIONS },
        { xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.NAVIGATING_THE_UNFRIENDLY_SEAS },
        { xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.AGAINST_ALL_ODDS },
    },
    [xi.job.PUP] =
    {
        { xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.THE_WAYWARD_AUTOMATION },
        { xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.OPERATION_TEATIME },
        { xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.PUPPETMASTER_BLUES },
    },
    [xi.job.DNC] =
    {
        { xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_UNFINISHED_WALTZ },
        { xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_ROAD_TO_DIVADOM },
        { xi.quest.log_id.JEUNO, xi.quest.id.jeuno.COMEBACK_QUEEN },
    },
    [xi.job.SCH] =
    {
        { xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.ON_SABBATICAL },
        { xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.DOWNWARD_HELIX },
        { xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.SEEING_BLOOD_RED },
    },
}

local checkArtifactProgress = function(player, job)
    if job < xi.job.BLU then -- Boring jobs
        if
            player:hasCompletedQuest(afQuestInfo[job][3][1], afQuestInfo[job][3][2]) and
            player:hasCompletedQuest(afQuestInfo[job][4][1], afQuestInfo[job][4][2])
        then
            return true
        end
    elseif job <= xi.job.SCH then -- Cool jobs
        if not player:hasCompletedQuest(afQuestInfo[job][3][1], afQuestInfo[job][3][2]) then
            return false
        end

        -- Blue Mage counts down the pieces completed in a bitmask
        if
            job == xi.job.BLU and
            player:getCharVar("[BLUAF]Remaining") == 0
        then
            return true
        end

        -- Corsair uses 3 different vars
        if
            job == xi.job.COR and
            player:getCharVar("LeleroonsLetterGreen") == 5 and
            player:getCharVar("LeleroonsLetterBlue") == 5 and
            player:getCharVar("LeleroonsLetterRed") == 5
        then
            return true
        end

        -- Puppetmaster counts down the pieces completed in a bitmask
        -- TODO: PUP AF crafting not ported from wings yet
        if
            job == xi.job.PUP and
            player:getCharVar("[PUPAF]Remaining") == 0
        then
            return true
        end

        -- Dancer counts up the pieces completed in a bitmask
        -- TODO: DNC AF crafting not ported from wings yet
        if
            job == xi.job.DNC and
            player:getCharVar("dancerCompletedAF") == 7
        then
            return true
        end

        -- Scholar has a var for AF complete
        if
            job == xi.job.SCH and
            player:getCharVar("AF_SCH_COMPLETE") == 1
        then
            return true
        end
    end

    return false
end

local onArtifactQuesetReset = function(player, job)
    -- onEventFinish is sanity checking params - so we dont have to here
    player:delGil(10000)
    player:delQuest(afQuestInfo[job][1][1], afQuestInfo[job][1][2])
    player:delQuest(afQuestInfo[job][2][1], afQuestInfo[job][2][2])
    player:delQuest(afQuestInfo[job][3][1], afQuestInfo[job][3][2])

    if job == xi.job.BLU then
        player:setCharVar("[BLUAF]Current", 0)
        player:setCharVar("[BLUAF]CraftingStage", 0)
        player:setCharVar("[BLUAF]Remaining", 7)
        player:setCharVar("[BLUAF]PaymentDay", 0)
        player:setCharVar("[BLUAF]RestingDay", 0)
    elseif job == xi.job.COR then
        player:setCharVar("LeleroonsLetterGreen", 0)
        player:setCharVar("LeleroonsLetterBlue", 0)
        player:setCharVar("LeleroonsLetterRed", 0)
    elseif job == xi.job.PUP then
        player:setCharVar("[PUPAF]Current", 0)
        player:setCharVar("[PUPAF]Remaining", 7)
        player:setCharVar("[PUPAF]TradeDone", 0)
        player:setCharVar("[PUPAF]TradeDay", 0)
    elseif job == xi.job.DNC then
        player:setCharVar("dancerCompletedAF", 0)
        player:setCharVar("dancerTailorCS", 0)
        player:setCharVar("dancerAFChoice", 0)
    elseif job == xi.job.SCH then
        player:setCharVar("AF_SCH_COMPLETE", 0)
        player:setCharVar("AF_Loussaire", 0)
        player:setCharVar("AF_SCH_BOOTS", 0)
        player:setCharVar("AF_SCH_PANTS", 0)
        player:setCharVar("AF_SCH_BODY", 0)
    elseif job < xi.job.BLU then -- All Dark Spark AF jobs
        player:delQuest(afQuestInfo[job][4][1], afQuestInfo[job][4][2])
    end
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local gil = player:getGil()
    -- Filter/Param0 - bitmask that hides what is matched
    --   1 hides "I have changed my mind".  2 hides War.  4 hides Mnk.  6 hides Mnk and War.
    --   1 << xi.job = mask for the job

    local filter = 8388606 -- this hides everything but "I have changed my mind".  Noteably - this also hides GEO and RUN.

    for i = xi.job.WAR, xi.job.SCH do
        if checkArtifactProgress(player, i) then
            filter = filter - (bit.lshift(1, i))
        end
    end

    player:startEvent(10034, filter, gil)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if
        option >= 1 and
        option <= 20
    then
        onArtifactQuesetReset(player, option)
    end
end

return entity
