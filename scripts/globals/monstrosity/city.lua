-----------------------------------
-- Monstrosity - City NPCs
-- The Odyssean Passage to the Feretory and the gladiator menus. Until the quest is complete,
-- scripts/quests/otherAreas/Monstrosity.lua answers the Suspicious NPCs first.
-----------------------------------
xi = xi or {}
xi.monstrosity = xi.monstrosity or {}

-- Slots and costs are fixed in the client event. JP wiki: only a writ holder may exchange.
local prestigeRewards =
{
    [0] = { item = xi.item.PHIAL_OF_ALLOY_TONIC,    cost =  5000 },
    [1] = { item = xi.item.PHIAL_OF_ALLOY_TONIC_P1, cost = 10000 },
    [2] = { item = xi.item.PHIAL_OF_ALLOY_TONIC_P2, cost = 20000 },
    [3] = { item = xi.item.FIEND_TORQUE,            cost = 10000 },
    [4] = { item = xi.item.ANIMOSITY_TORQUE,        cost = 25000 },
    [5] = { item = xi.item.LACERATION_TORQUE,       cost = 25000 },
    [6] = { item = xi.item.GOETIC_TORQUE,           cost = 25000 },
}

xi.monstrosity.cityPassageOnTrigger = function(player, npc)
    if
        xi.settings.main.ENABLE_MONSTROSITY ~= 1 or
        not player:hasKeyItem(xi.keyItem.RING_OF_SUPERNAL_DISJUNCTION)
    then
        player:messageSpecial(zones[player:getZoneID()].text.NOTHING_HAPPENS)
        return
    end

    player:startEvent(xi.monstrosity.cityEvents[player:getZoneID()] + xi.monstrosity.cityEvent.PASSAGE)
end

xi.monstrosity.cityPassageOnEventFinish = function(player, csid, option, npc)
    if
        option ~= 1 or
        csid ~= xi.monstrosity.cityEvents[player:getZoneID()] + xi.monstrosity.cityEvent.PASSAGE
    then
        return
    end

    local pos = player:getPos()
    player:setMonstrosityEntryData(pos.x, pos.y, pos.z, pos.rot, player:getZoneID(), player:getMainJob(), player:getSubJob())

    local entrance = xi.monstrosity.feretoryEntrance
    player:setPos(entrance.x, entrance.y, entrance.z, entrance.rot, xi.zone.FERETORY)
end

-- JP wiki: talking to the Suspicious Hume after the quest opens the gladiator menus in the cities.
-- The Hume's events do not follow cityEvent.
local humeGladiatorEvent = 45

xi.monstrosity.suspiciousHumeOnTrigger = function(player, npc)
    if
        xi.settings.main.ENABLE_MONSTROSITY ~= 1 or
        not player:hasCompletedQuest(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.MONSTROSITY)
    then
        return
    end

    player:startEvent(humeGladiatorEvent)
end

xi.monstrosity.suspiciousHumeOnEventFinish = function(player, csid, option, npc)
    if csid == humeGladiatorEvent then
        player:setCharVar('[Monstrosity]Gladiator', 1)
    end
end

xi.monstrosity.gladiatorOnTrigger = function(player, npc)
    local baseEvent = xi.monstrosity.cityEvents[player:getZoneID()]
    if
        xi.settings.main.ENABLE_MONSTROSITY ~= 1 or
        not player:hasCompletedQuest(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.MONSTROSITY)
    then
        player:startEvent(baseEvent + xi.monstrosity.cityEvent.CHATTER)
        return
    end

    if player:getCharVar('[Monstrosity]Gladiator') == 0 then
        player:startEvent(baseEvent + xi.monstrosity.cityEvent.GLADIATOR_INTRO)
        return
    end

    -- Param 2 picks the banter line. Retail sent 1 on every visit. A zero param 3 hides the PT content option.
    local hasWrit = player:hasKeyItem(xi.keyItem.GLADIATORIAL_WRIT_OF_SUMMONS) and 1 or 0
    player:startEvent(baseEvent + xi.monstrosity.cityEvent.GLADIATOR_MENU, hasWrit, player:getCurrency('prestige'), 1)
end

-- The menu answers 123 to take the writ, 321 to return it, and 1 plus the slot from bit 16 to exchange.
xi.monstrosity.gladiatorOnEventFinish = function(player, csid, option, npc)
    if csid ~= xi.monstrosity.cityEvents[player:getZoneID()] + xi.monstrosity.cityEvent.GLADIATOR_MENU then
        return
    end

    local takeWrit   = 123
    local returnWrit = 321

    if option == takeWrit then
        npcUtil.giveKeyItem(player, xi.keyItem.GLADIATORIAL_WRIT_OF_SUMMONS)
    elseif option == returnWrit then
        player:delKeyItem(xi.keyItem.GLADIATORIAL_WRIT_OF_SUMMONS)
        player:messageSpecial(zones[player:getZoneID()].text.KEYITEM_LOST, xi.keyItem.GLADIATORIAL_WRIT_OF_SUMMONS)
    elseif bit.band(option, 0xFFFF) == 1 then
        local reward = prestigeRewards[bit.rshift(option, 16)]
        if
            reward and
            player:hasKeyItem(xi.keyItem.GLADIATORIAL_WRIT_OF_SUMMONS) and
            player:getCurrency('prestige') >= reward.cost and
            npcUtil.giveItem(player, reward.item)
        then
            player:delCurrency('prestige', reward.cost)
        end
    end
end
