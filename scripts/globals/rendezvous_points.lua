----------------------------------------------
-- Shared functionality for Rendezvous Points
-- For interacting with Adventuring Fellow
----------------------------------------------
require("scripts/globals/fellow_utils")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/zone")
----------------------------------------------
xi = xi or {}
xi.rendezvousPoints = xi.rendezvousPoints or {}
-- xi.items.SIGNAL_PEARL                    = 14810,
-- xi.items.TACTICS_PEARL                   = 14811,
-- xi.items.TACTICS_MANUAL_OF_FORTITUDE     = 1820,
-- xi.items.TACTICS_MANUAL_OF_MIGHT         = 1839,
-- xi.items.TACTICS_MANUAL_OF_ENDURANCE     = 1876,

local cutscenes =
{
    [xi.zone.NORTHERN_SAN_DORIA]  = { standard = 779, manual = 781, tactics = 780 },
    [xi.zone.PORT_BASTOK]  = { standard = 347, manual = 351, tactics = 350 },
    [xi.zone.WINDURST_WATERS]  = { standard = 903, manual = 915, tactics = 914 },
    [xi.zone.RULUDE_GARDENS]  = { standard = 10069, manual = 10072, tactics = 10071 },
    [xi.zone.AHT_URHGAN_WHITEGATE]  = { standard = 966, manual = 965, tactics = 964 },
}

xi.rendezvousPoints.onTrigger = function(player, npc)
    local zone          = player:getZoneID()
    local optionsMask   = player:getFellowValue("optionsMask")
    local bond          = player:getFellowValue("bond")
    local menuParam     = 240 -- default chat, quests, battle options
    if bond >= 30 then
        menuParam = menuParam - 16
    end -- appearances option

    if not player:hasItem(xi.items.SIGNAL_PEARL) then
        menuParam = menuParam - 32
    end -- need pearl option

    local pearl         = 0 -- able to recieve dropped pearl
    if player:getFellowValue("pearlTime") > os.time() then
        pearl = 1
    end -- not able

    local styleParam    = xi.fellow_utils.getStyleParam(player)
    local lookParam     = xi.fellow_utils.getLookParam(player)
    local fellowParam   = xi.fellow_utils.getFellowParam(player)

    if player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.MIRROR_MIRROR) == QUEST_COMPLETED then
        if player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.CHAMELEON_CAPERS) == QUEST_COMPLETED then
            if
                player:hasItem(xi.items.TACTICS_MANUAL_OF_FORTITUDE) and
                (bit.band(optionsMask, bit.lshift(1, 5)) == 0)
            then -- T.M. Fortitude
                player:startEvent(cutscenes[zone].manual, zone, 1820, 0, 0, 0, styleParam, lookParam, fellowParam)
            elseif
                player:hasItem(xi.items.TACTICS_MANUAL_OF_MIGHT) and
                (bit.band(optionsMask, bit.lshift(1, 6)) == 0)
            then -- T.M. Might
                player:startEvent(cutscenes[zone].manual, zone, 1839, 0, 0, 0, styleParam, lookParam, fellowParam)
            elseif
                player:hasItem(xi.items.TACTICS_MANUAL_OF_ENDURANCE) and
                (bit.band(optionsMask, bit.lshift(1, 7)) == 0)
            then -- T.M. Endurance
                player:startEvent(cutscenes[zone].manual, zone, 1876, 0, 0, 0, styleParam, lookParam, fellowParam)
            else
                player:startEvent(cutscenes[zone].standard, zone, menuParam, 0, 0, pearl, styleParam, lookParam, fellowParam)
            end
        else
            player:startEvent(cutscenes[zone].standard, zone, menuParam, 0, 0, pearl, styleParam, lookParam, fellowParam)
        end
    end
end

-- Disable cyclomatic complexity check for this function:
-- luacheck: ignore 561
-- TODO: Reduce complexity in this function by breaking out sections to helper functions
xi.rendezvousPoints.onEventUpdate = function(player, csid, option)
    local zone          = player:getZoneID()
    local optionsMask   = player:getFellowValue("optionsMask")
    local job           = player:getFellowValue("job")
    local bond          = player:getFellowValue("bond")
    local armorLock     = player:getFellowValue("armorLock")
    local styleParam    = xi.fellow_utils.getStyleParam(player)
    local lookParam     = xi.fellow_utils.getLookParam(player)
    local fellowParam   = xi.fellow_utils.getFellowParam(player)
    local questParam    = 0 -- default quest chat
    -- TODO: Quest options as quests are implemented
    if player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.PAST_REFLECTIONS) == QUEST_ACCEPTED then
    --    if player:getCharVar("[Quest]PastReflections") == 2 then
            questParam = 1
    --    end
    end

    local tacticsParam = 0 -- tactics pearl quest
    if
        bond >= 35 and not player:hasKeyItem(xi.ki.EMPTINESS_INVESTIGATION_NOTE) and
        os.time() > player:getFellowValue("tacticsTime")
    then -- 1 per conquest tally
        tacticsParam = 1
    end

    local battleParam = 232 -- default level, signals, weaponskills options
    if bond >= 5 then
        battleParam = battleParam - 8 -- combat styles option
    end

    local levelParam = bit.lshift(job, 8) + player:getFellowValue("level")
    local signalsParam = 244 -- low hp, low mp, other (healer, stalwart, soothing)
    switch (job) : caseof
    {
        [1] = function(x)
            signalsParam = 246
        end, -- low hp, other (shield)

        [2] = function(x)
            signalsParam = 242
        end, -- low hp, weaponskill, other (attacker)

        [5] = function(x)
            signalsParam = 242
        end, -- low hp, weaponskill, other (fierce)
    }
    local combatParam = 248 -- default shield, attacker, healer options
    if bit.band(optionsMask, bit.lshift(1, 5)) == 32 then
        combatParam = combatParam - 8
    end

    if bit.band(optionsMask, bit.lshift(1, 6)) == 64 then
        combatParam = combatParam - 16
    end

    if bit.band(optionsMask, bit.lshift(1, 7)) == 128 then
        combatParam = combatParam - 32
    end

    local appearanceParam = 252 -- default headwear option
    if bond >= 60 then
        appearanceParam = appearanceParam - 4 -- fashionable equipment option
    end

    local headwearParam = 65532 -- default level 1 option
    if bond >=  45 then
        headwearParam = headwearParam -   4
    end -- level 2 option

    if bond >=  55 then
        headwearParam = headwearParam -   8
    end -- level 3 option

    if bond >=  65 then
        headwearParam = headwearParam -  16
    end -- level 4 option

    if bond >=  75 then
        headwearParam = headwearParam -  32
    end -- level 5 option

    if bond >=  90 then
        headwearParam = headwearParam -  64
    end -- level 6 option

    if bond >= 105 then
        headwearParam = headwearParam - 128
    end -- level 7 option

    if bond >= 115 then
        headwearParam = headwearParam - 256
    end -- level 8 option

    local equipmentParam = 192 -- default selection options that don't change
    local equipLocksParam = 0 -- how many additional pieces can be locked after the first
    if bond >= 75 then
        equipLocksParam = 1
    end

    if bond >= 95 then
        equipLocksParam = 2
    end

    if
        csid == cutscenes[zone].standard and
        option == 0xA000000
    then -- call for fellow
        player:updateEvent(zone, 0, 0, 0, 0, styleParam, lookParam, fellowParam)
        local lastBondFromChatTime = player:getCharVar("bondFromChatTime")
        if os.time() > lastBondFromChatTime then
            player:setCharVar("bondFromChatTime", JstMidnight())
            player:setFellowValue("bond", bond + 1)
        end
    elseif
        csid == cutscenes[zone].standard and
        option == 0xA000004
    then -- need signal pearl
        if npcUtil.giveItem(player, xi.items.SIGNAL_PEARL) then
            if bond >= 5 then
                player:setFellowValue("bond", bond - 5)
            else
                player:setFellowValue("bond", 0)
            end

            player:setFellowValue("pearlTime", JstMidnight()) -- 1 pearl per day
        end
    elseif
        csid == cutscenes[zone].standard and
        (option == 0xA000006 or
        option == 0x5000006)
    then -- talk about quests
        player:updateEvent(zone, 0, questParam, tacticsParam, 0, styleParam, lookParam, fellowParam)
    elseif
        csid == cutscenes[zone].standard and
        (option == 0xA00000F or
        option == 0x500000F)
    then -- tactics pearl quest
        npcUtil.giveKeyItem(player, xi.ki.EMPTINESS_INVESTIGATION_NOTE)
        player:setFellowValue("tacticsTime", getConquestTally()) -- 1 per conquest tally
    elseif
        csid == cutscenes[zone].standard and
        (option == 0xA000007 or
        option == 0x5000007)
    then -- talk about battle
        player:updateEvent(zone, 0, battleParam, 0, 0, styleParam, levelParam, fellowParam)
    elseif
        csid == cutscenes[zone].standard and
        (option == 0xA000008 or
        option == 0x5000008)
    then -- talk about appearances
        player:updateEvent(zone, 0, appearanceParam, 0, 0, styleParam, lookParam, fellowParam)
    elseif
        csid == cutscenes[zone].standard and
        (option == 0xA00000B or
        option == 0x500000B)
    then -- headwear
        player:updateEvent(zone, 0, headwearParam, 0, 0, styleParam, lookParam, fellowParam)
    elseif
        csid == cutscenes[zone].standard and
        (option == 0xA000103 or
        option == 0x5000103)
    then -- headwear option 1
        player:setFellowValue("head", 1)
    elseif
        csid == cutscenes[zone].standard and
        (option == 0xA000203 or
        option == 0x5000203)
    then -- headwear option 2
        player:setFellowValue("head", 2)
    elseif
        csid == cutscenes[zone].standard and
        (option == 0xA000303 or
        option == 0x5000303)
    then -- headwear option 3
        player:setFellowValue("head", 3)
    elseif
        csid == cutscenes[zone].standard and
        (option == 0xA000403 or
        option == 0x5000403)
    then -- headwear option 4
        player:setFellowValue("head", 4)
    elseif
        csid == cutscenes[zone].standard and
        (option == 0xA000503 or
        option == 0x5000503)
    then -- headwear option 5
        player:setFellowValue("head", 5)
    elseif
        csid == cutscenes[zone].standard and
        (option == 0xA000603 or
        option == 0x5000603)
    then -- headwear option 6
        player:setFellowValue("head", 6)
    elseif
        csid == cutscenes[zone].standard and
        (option == 0xA000703 or
        option == 0x5000703)
    then -- headwear option 7
        player:setFellowValue("head", 7)
    elseif
        csid == cutscenes[zone].standard and
        (option == 0xA000803 or
        option == 0x5000803)
    then -- headwear option 8
        player:setFellowValue("head", 8)
    elseif
        csid == cutscenes[zone].standard and
        (option == 0xA000903 or
        option == 0x5000903)
    then -- headwear option 9
        player:setFellowValue("head", 9)
    elseif
        csid == cutscenes[zone].standard and
        (option == 0xA001003 or
        option == 0x5001003)
    then -- headwear option 10
        player:setFellowValue("head", 0)
    elseif
        csid == cutscenes[zone].standard and
        (option == 0xA00000C or
        option == 0x500000C)
    then -- fashionable equipment
        player:updateEvent(zone, 0, equipmentParam, equipLocksParam, 0, styleParam, lookParam, fellowParam)
    elseif
        csid == cutscenes[zone].standard and
        (option == 0xA00010D or
        option == 0x500010D)
    then -- body
        player:setFellowValue("armorLock", 2)
        player:updateEvent(zone, 0, 2, equipLocksParam, 0, styleParam, lookParam, fellowParam)
    elseif
        csid == cutscenes[zone].standard and
        (option == 0xA00020D or
        option == 0x500020D)
    then -- hands
        player:setFellowValue("armorLock", 4)
        player:updateEvent(zone, 0, 4, equipLocksParam, 0, styleParam, lookParam, fellowParam)
    elseif
        csid == cutscenes[zone].standard and
        (option == 0xA00030D or
        option == 0x500030D)
    then -- legs
        player:setFellowValue("armorLock", 8)
        player:updateEvent(zone, 0, 8, equipLocksParam, 0, styleParam, lookParam, fellowParam)
    elseif
        csid == cutscenes[zone].standard and
        (option == 0xA00040D or
        option == 0x500040D)
    then -- feet
        player:setFellowValue("armorLock", 16)
        player:updateEvent(zone, 0, 16, equipLocksParam, 0, styleParam, lookParam, fellowParam)
    elseif
        csid == cutscenes[zone].standard and
        (option == 0xA00050D or
        option == 0x500050D)
    then -- none
        player:setFellowValue("armorLock", 0)
        player:updateEvent(zone, 0, 0, 0, 0, styleParam, lookParam, fellowParam)
    elseif
        csid == cutscenes[zone].standard and
        (option == 0xA00010E or
        option == 0x500010E)
    then -- body 2
        player:setFellowValue("armorLock", armorLock + 2)
        player:updateEvent(zone, 0, armorLock + 2, equipLocksParam, 0, styleParam, lookParam, fellowParam)
    elseif
        csid == cutscenes[zone].standard and
        (option == 0xA00020E or
        option == 0x500020E)
    then -- hands 2
        player:setFellowValue("armorLock", armorLock + 4)
        player:updateEvent(zone, 0, armorLock + 4, equipLocksParam, 0, styleParam, lookParam, fellowParam)
    elseif
        csid == cutscenes[zone].standard and
        (option == 0xA00030E or
        option == 0x500030E)
    then -- legs 2
        player:setFellowValue("armorLock", armorLock + 8)
        player:updateEvent(zone, 0, armorLock + 8, equipLocksParam, 0, styleParam, lookParam, fellowParam)
    elseif
        csid == cutscenes[zone].standard and
        (option == 0xA00040E or
        option == 0x500040E)
    then -- feet 2
        player:setFellowValue("armorLock", armorLock + 16)
        player:updateEvent(zone, 0, armorLock + 16, equipLocksParam, 0, styleParam, lookParam, fellowParam)
    elseif
        csid == cutscenes[zone].standard and
        option == 0x1000007
    then -- level and style
        player:updateEvent(zone, 0, 0, 0, 0, 0, levelParam, fellowParam)
    elseif
        csid == cutscenes[zone].standard and
        (option == 0xA000009 or
        option == 0x5000009)
    then -- combat signals
        player:updateEvent(zone, 0, signalsParam, 0, 0, styleParam, lookParam, fellowParam)
    elseif
        csid == cutscenes[zone].standard and
        (option == 0xA000101 or
        option == 0x5000101)
    then -- combat signals - low hp [YES]
        optionsMask = bit.bor(optionsMask, bit.lshift(1, 1))
        player:setFellowValue("optionsMask", optionsMask)
    elseif
        csid == cutscenes[zone].standard and
        (option == 0xA000201 or
        option == 0x5000201)
    then -- combat signals - low hp [NO]
        if bit.band(optionsMask, bit.lshift(1, 1)) == 2 then
            optionsMask = bit.bxor(optionsMask, bit.lshift(1, 1))
            player:setFellowValue("optionsMask", optionsMask)
        end
    elseif
        csid == cutscenes[zone].standard and
        (option == 0xA000301 or
        option == 0x5000301)
    then -- combat signals - low mp [YES]
        optionsMask = bit.bor(optionsMask, bit.lshift(1, 2))
        player:setFellowValue("optionsMask", optionsMask)
    elseif
        csid == cutscenes[zone].standard and
        (option == 0xA000401 or
        option == 0x5000401)
    then -- combat signals - low mp [NO]
        if bit.band(optionsMask, bit.lshift(1, 2)) == 4 then
            optionsMask = bit.bxor(optionsMask, bit.lshift(1, 2))
            player:setFellowValue("optionsMask", optionsMask)
        end
    elseif
        csid == cutscenes[zone].standard and
        (option == 0xA000501 or
        option == 0x5000501)
    then -- combat signals - ws use [YES]
        optionsMask = bit.bor(optionsMask, bit.lshift(1, 3))
        player:setFellowValue("optionsMask", optionsMask)
    elseif
        csid == cutscenes[zone].standard and
        (option == 0xA000601 or
        option == 0x5000601)
    then -- combat signals - ws use [NO]
        if bit.band(optionsMask, bit.lshift(1, 3)) == 8 then
            optionsMask = bit.bxor(optionsMask, bit.lshift(1, 3))
            player:setFellowValue("optionsMask", optionsMask)
        end
    elseif
        csid == cutscenes[zone].standard and
        (option == 0xA000701 or
        option == 0x5000701)
    then -- combat signals - other [YES]
        optionsMask = bit.bor(optionsMask, bit.lshift(1, 4))
        player:setFellowValue("optionsMask", optionsMask)
    elseif
        csid == cutscenes[zone].standard and
        (option == 0xA000801 or
        option == 0x5000801)
    then -- combat signals - other [NO]
        if bit.band(optionsMask, bit.lshift(1, 4)) == 16 then
            optionsMask = bit.bxor(optionsMask, bit.lshift(1, 4))
            player:setFellowValue("optionsMask", optionsMask)
        end
    elseif
        csid == cutscenes[zone].standard and
        (option == 0xA000010 or
        option == 0x5000010)
    then -- ws aoe [NO]
        if bit.band(optionsMask, bit.lshift(1, 0)) == 1 then
            optionsMask = bit.bxor(optionsMask, bit.lshift(1, 0))
            player:setFellowValue("optionsMask", optionsMask)
        end
    elseif
        csid == cutscenes[zone].standard and
        (option == 0xA000110 or
        option == 0x5000110)
    then -- ws aoe [YES]
        optionsMask = bit.bor(optionsMask, bit.lshift(1, 0))
        player:setFellowValue("optionsMask", optionsMask)
    elseif
        csid == cutscenes[zone].standard and
        (option == 0xA00000A or
        option == 0x500000A)
    then -- combat styles
        player:updateEvent(zone, 0, combatParam, 0, 0, styleParam, lookParam, fellowParam)
    elseif
        csid == cutscenes[zone].standard and
        (option == 0xA000102 or
        option == 0x5000102)
    then -- shield style
        player:setFellowValue("job", 1)
    elseif
        csid == cutscenes[zone].standard and
        (option == 0xA000202 or
        option == 0x5000202)
    then -- attacker style
        player:setFellowValue("job", 2)
    elseif
        csid == cutscenes[zone].standard and
        (option == 0xA000302 or
        option == 0x5000302)
    then -- healer style
        player:setFellowValue("job", 3)
    elseif
        csid == cutscenes[zone].standard and
        (option == 0xA000402 or
        option == 0x5000402)
    then -- stalwart style
        player:setFellowValue("job", 4)
    elseif
        csid == cutscenes[zone].standard and
        (option == 0xA000502 or
        option == 0x5000502)
    then -- fierce style
        player:setFellowValue("job", 5)
    elseif
        csid == cutscenes[zone].standard and
        (option == 0xA000602 or
        option == 0x5000602)
    then -- soothing style
        player:setFellowValue("job", 6)
    end
end

xi.rendezvousPoints.onEventFinish = function(player, csid, option)
    local optionsMask = player:getFellowValue("optionsMask")
    local zone = player:getZoneID()
    if csid == cutscenes[zone].manual and option == 1820 then -- T.M. Fortitude
        optionsMask = bit.bor(optionsMask, bit.lshift(1, 5))
        player:setFellowValue("optionsMask", optionsMask)
    elseif csid == cutscenes[zone].manual and option == 1839 then -- T.M. Might
        optionsMask = bit.bor(optionsMask, bit.lshift(1, 6))
        player:setFellowValue("optionsMask", optionsMask)
    elseif csid == cutscenes[zone].manual and option == 1876 then -- T.M. Endurance
        optionsMask = bit.bor(optionsMask, bit.lshift(1, 7))
        player:setFellowValue("optionsMask", optionsMask)
    end
end
