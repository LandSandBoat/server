-----------------------------------
-- BCNM Functions
-----------------------------------
require('scripts/globals/battlefield')
require('scripts/globals/missions')
require('scripts/globals/quests')
-----------------------------------
xi = xi or {}
xi.bcnm = xi.bcnm or {}

local battlefields =
{
    [xi.zone.THE_SHROUDED_MAW] =
    {
        { 0,  704,    0 },   -- Darkness Named (PM3-5)
        { 2,  706,    0 },   -- Waking Dreams (Quest)
    },

    [xi.zone.SEALIONS_DEN] =
    {
        { 0,  992,    0 },   -- One to Be Feared (PM6-4)
        { 1,  993,    0 },   -- The Warrior's Path (PM7-5)
    },

    [xi.zone.EMPYREAL_PARADOX] =
    {
        { 0, 1056,    0 },   -- Dawn (PM8-4)
        { 1, 1057,    0 },   -- Apocalypse Nigh (Quest)
    },
}

-----------------------------------
-- Check requirements for registrant and allies
-----------------------------------
local function checkReqs(player, npc, bfid, registrant)
    local battlefield = xi.battlefield.contents[bfid]
    if battlefield then
        return battlefield:checkRequirements(player, npc, registrant)
    end

    local promathiaMission = player:getCurrentMission(xi.mission.log_id.COP)
    local promathiaStatus  = player:getCharVar('PromathiaStatus')

    -- Requirements to register a battlefield
    local registerReqs =
    {
        [704] = function() -- PM3-5: Darkness Named
            return promathiaMission == xi.mission.id.cop.DARKNESS_NAMED and
                player:getCharVar('Mission[6][358]Status') == 4
        end,

        [706] = function() -- Quest: Waking Dreams
            return player:hasKeyItem(xi.ki.VIAL_OF_DREAM_INCENSE)
        end,

        [992] = function() -- PM6-4: One to be Feared
            return promathiaMission == xi.mission.id.cop.ONE_TO_BE_FEARED and
                player:getCharVar('Mission[6][638]Status') == 3
        end,

        [993] = function() -- PM7-5: The Warrior's Path
            return promathiaMission == xi.mission.id.cop.THE_WARRIORS_PATH and
                player:getCharVar('Mission[6][748]Status') == 1
        end,

        [1056] = function() -- PM8-4: Dawn
            return promathiaMission == xi.mission.id.cop.DAWN and
                promathiaStatus == 2
        end,

        [1057] = function() -- Apocalypse Nigh
            return player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH) == xi.questStatus.QUEST_ACCEPTED and
                player:getCharVar('ApocalypseNigh') == 4
        end,
    }

    -- Requirements to enter a battlefield already registered by a party member
    local enterReqs =
    {
        [640] = function() -- PM5-3 U3: Flames for the Dead
            return npc:getXPos() > -721 and npc:getXPos() < 719
        end,

        [1057] = function() -- Quest: Apocalypse Nigh
            return player:hasCompletedQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH) or
                (
                    player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH) == xi.questStatus.QUEST_ACCEPTED and
                    player:getCharVar('ApocalypseNigh') == 4
                )
        end,
    }

    -- Determine whether player meets battlefield requirements
    local req = registrant and registerReqs[bfid] or enterReqs[bfid]

    if not req or req() then
        return true
    else
        return false
    end
end

-----------------------------------
-- check ability to skip a cutscene
-----------------------------------
local function checkSkip(player, bfid)
    local battlefield = xi.battlefield.contents[bfid]
    if battlefield then
        return battlefield:checkSkipCutscene(player)
    end

    local promathiaMission = player:getCurrentMission(xi.mission.log_id.COP)
    local promathiaStatus  = player:getCharVar('PromathiaStatus')

    -- Requirements to skip a battlefield
    local skipReqs =
    {
        [704] = function() -- PM3-5: Darkness Named
            return player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.DARKNESS_NAMED) or
                (
                    promathiaMission == xi.mission.id.cop.DARKNESS_NAMED and
                    player:getCharVar('Mission[6][358]Status') == 5
                )
        end,

        [706] = function() -- Quest: Waking Dreams
            return player:hasCompletedQuest(xi.questLog.WINDURST, xi.quest.id.windurst.WAKING_DREAMS) or
                player:hasKeyItem(xi.ki.WHISPER_OF_DREAMS)
        end,

        [993] = function() -- PM7-5: The Warrior's Path
            return player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_WARRIORS_PATH)
        end,

        [1056] = function() -- PM8-4: Dawn
            return player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.DAWN) or
                (
                    promathiaMission == xi.mission.id.cop.DAWN and
                    promathiaStatus > 2
                )
        end,

        [1057] = function() -- Apocalypse Nigh
            return player:hasCompletedQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH)
        end,
    }

    -- Determine whether player meets cutscene skip requirements
    local req = skipReqs[bfid]

    if not req then
        return false
    elseif req() then
        return true
    end

    return false
end

-----------------------------------
-- Which battlefields are valid for registrant?
-----------------------------------
local function findBattlefields(player, npc, itemId)
    local mask = 0
    local zbfs = battlefields[player:getZoneID()]

    if zbfs == nil then
        return 0
    end

    for k, v in pairs(zbfs) do
        if
            v[3] == itemId and
            checkReqs(player, npc, v[2], true) and
            not player:battlefieldAtCapacity(v[2])
        then
            mask = bit.bor(mask, math.pow(2, v[1]))
        end
    end

    return mask
end

-----------------------------------
-- Get battlefield id for a given zone and bit
-----------------------------------
local function getBattlefieldIdByBit(player, bit)
    local zbfs = battlefields[player:getZoneID()]

    if not zbfs then
        return 0
    end

    for k, v in pairs(zbfs) do
        if v[1] == bit then
            return v[2]
        end
    end

    return 0
end

-----------------------------------
-- Get battlefield bit for a given zone and id
-----------------------------------
local function getBattlefieldMaskById(player, bfid)
    local zbfs = battlefields[player:getZoneID()]

    if zbfs then
        for k, v in pairs(zbfs) do
            if v[2] == bfid then
                return math.pow(2, v[1])
            end
        end
    end

    return 0
end

-----------------------------------
-- Get battlefield bit for a given zone and id
-----------------------------------
local function getItemById(player, bfid)
    local zbfs = battlefields[player:getZoneID()]

    if zbfs then
        for k, v in pairs(zbfs) do
            if v[2] == bfid then
                return v[3]
            end
        end
    end

    return 0
end

-----------------------------------
-- onTrade Action
-----------------------------------

xi.bcnm.onTrade = function(player, npc, trade, onUpdate)
    if xi.battlefield.rejectLevelSyncedParty(player, npc) then -- player's party has level sync, abort.
        return false
    end

    -- Validate trade
    local itemId

    if not trade then
        return false

    -- Orbs / Testimonies
    else
        itemId = trade:getItemId(0)

        if
            itemId == nil or
            itemId < 1 or
            itemId > 65535 or
            trade:getItemCount() ~= 1 or
            trade:getSlotQty(0) ~= 1
        then
            return false

        -- Check for already used Orb or testimony.
        elseif player:getWornUses(itemId) > 0 then
            player:messageBasic(xi.msg.basic.ITEM_UNABLE_TO_USE_2, 0, 0) -- Unable to use item.
            return false
        end
    end

    -- Validate battlefield status
    if player:hasStatusEffect(xi.effect.BATTLEFIELD) and not onUpdate then
        player:messageBasic(xi.msg.basic.WAIT_LONGER, 0, 0) -- You must wait longer to perform that action.

        return false
    end

    -- Check if another party member has battlefield status effect. If so, don't allow trade.
    local alliance = player:getAlliance()
    for _, member in pairs(alliance) do
        if member:hasStatusEffect(xi.effect.BATTLEFIELD) then
            player:messageBasic(xi.msg.basic.WAIT_LONGER, 0, 0) -- You must wait longer to perform that action.

            return false
        end
    end

    -- Open menu of valid battlefields
    local validBattlefields = findBattlefields(player, npc, itemId)

    if validBattlefields ~= 0 then
        if not onUpdate then
            player:startEvent(32000, 0, 0, 0, validBattlefields, 0, 0, 0, 0)
        end

        return true
    end

    return false
end

-----------------------------------
-- onTrigger Action
-----------------------------------
xi.bcnm.onTrigger = function(player, npc)
    -- Cannot enter if anyone in party is level/master sync'd
    if xi.battlefield.rejectLevelSyncedParty(player, npc) then
        return false
    end

    -- Player has battlefield status effect. That means a battlefield is open OR the player is inside a battlefield.
    if player:hasStatusEffect(xi.effect.BATTLEFIELD) then
        -- Player is inside battlefield. Attempting to leave.
        if player:getBattlefield() then
            player:startOptionalCutscene(32003)

            return true

        -- Player is outside battlefield. Attempting to enter.
        else
            local stat = player:getStatusEffect(xi.effect.BATTLEFIELD)
            local bfid = stat:getPower()
            local mask = getBattlefieldMaskById(player, bfid)

            if mask ~= 0 and checkReqs(player, npc, bfid, false) then
                player:startEvent(32000, 0, 0, 0, mask, 0, 0, 0, 0)

                return true
            end
        end

    -- Player doesn't have battlefield status effect. That means player wants to register a new battlefield OR is attempting to enter a closed one.
    else
        -- Check if another party member has battlefield status effect. If so, that means the player is trying to enter a closed battlefield.
        local alliance = player:getAlliance()
        for _, member in pairs(alliance) do
            if member:hasStatusEffect(xi.effect.BATTLEFIELD) then
                -- player:messageSpecial() -- You are eligible but cannot enter.

                return false
            end
        end

        -- No one in party/alliance has battlefield status effect. We want to register a new battlefield.
        local mask = findBattlefields(player, npc, 0)

        -- GMs get access to all BCNMs
        if player:getGMLevel() > 0 and player:getVisibleGMLevel() >= 3 then
            mask = 268435455
        end

        -- mask = 268435455 -- uncomment to open menu with all possible battlefields
        if mask ~= 0 then
            player:startEvent(32000, 0, 0, 0, mask, 0, 0, 0, 0)
            return true
        end
    end

    return false
end

-----------------------------------
-- onEventUpdate
-----------------------------------
xi.bcnm.onEventUpdate = function(player, csid, option, extras)
    -- player:printToPlayer(string.format('EventUpdateBCNM csid=%i option=%i extras=%i', csid, option, extras))

    -- Requesting a battlefield
    if csid == 32000 then
        if option == 0 then
            -- todo: check if battlefields full, check party member requiremenst
            return 0
        elseif option == 255 then
            -- todo: check if battlefields full, check party member requirements
            return 0
        end

        local area = player:getLocalVar('[battlefield]area')
        area       = area + 1

        local battlefieldIndex = bit.rshift(option, 4)
        local battlefieldId    = getBattlefieldIdByBit(player, battlefieldIndex)
        local id               = battlefieldId or player:getBattlefieldID()
        local skip             = checkSkip(player, id)

        local clearTime = 1
        local name      = 'Meme'
        local partySize = 1

        local result = xi.battlefield.returnCode.REQS_NOT_MET
        result       = player:registerBattlefield(id, area)
        local status = xi.battlefield.status.OPEN

        if result ~= xi.battlefield.returnCode.CUTSCENE then
            if result == xi.battlefield.returnCode.INCREMENT_REQUEST then
                if area < 3 then
                    player:setLocalVar('[battlefield]area', area)
                else
                    result = xi.battlefield.returnCode.WAIT
                    player:updateEvent(result)
                end
            end

            return false
        else
            -- Only allow entrance if battlefield is open and playerhas battlefield effect, witch can be lost mid battlefield selection.
            if
                not player:getBattlefield() and
                player:hasStatusEffect(xi.effect.BATTLEFIELD)
                -- and id:getStatus() == xi.battlefield.status.OPEN -- TODO: Uncomment only once that can-of-worms is dealt with.
            then
                player:enterBattlefield()
            end

            -- Handle record
            local initiatorId   = 0
            local initiatorName = ''
            local battlefield   = player:getBattlefield()

            if battlefield then
                battlefield:setLocalVar('[cs]bit', battlefieldIndex)
                name, clearTime, partySize = battlefield:getRecord()
                initiatorId, initiatorName = battlefield:getInitiator()
            end

            -- Register party members
            if initiatorId == player:getID() then
                local effect = player:getStatusEffect(xi.effect.BATTLEFIELD)
                local zone   = player:getZoneID()
                local item   = getItemById(player, effect:getPower())

                -- Handle traded items
                if item ~= 0 then
                    -- Set other traded item to worn
                    if player:hasItem(item) and player:getName() == initiatorName then
                        player:incrementItemWear(item)
                    end
                end

                -- Handle party/alliance members
                local alliance = player:getAlliance()
                for _, member in pairs(alliance) do
                    if
                        member:getZoneID() == zone and
                        not member:hasStatusEffect(xi.effect.BATTLEFIELD) and
                        not member:getBattlefield()
                    then
                        member:addStatusEffect(effect)
                        member:registerBattlefield(id, area, player:getID())
                    end
                end
            end
        end

        player:updateEvent(result, battlefieldIndex, 0, clearTime, partySize, skip)
        player:updateEventString(name)
        return status < xi.battlefield.status.LOCKED and result < xi.battlefield.returnCode.LOCKED

    -- Leaving a battlefield
    elseif csid == 32003 and option == 2 then
        player:updateEvent(3)
        return true
    elseif csid == 32003 and option == 3 then
        player:updateEvent(0)
        return true
    end

    return false
end

-----------------------------------
-- onEventFinish Action
-----------------------------------

xi.bcnm.onEventFinish = function(player, csid, option, npc)
    player:setLocalVar('[battlefield]area', 0)

    if player:hasStatusEffect(xi.effect.BATTLEFIELD) then
        if csid == 32003 and option == 4 then
            if player:getBattlefield() then
                player:leaveBattlefield(1)
            end
        end

        return true
    end

    return false
end
