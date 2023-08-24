-----------------------------------
-- Area: Ru'Lud Gardens
--  NPC: Venessa
-----------------------------------
local ID = require("scripts/zones/RuLude_Gardens/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

local rewards =
{
    {   xi.items.BRILLIANT_VISION,  xi.items.SUMMONING_EARRING },
    {     xi.items.PAINFUL_VISION,       xi.items.DARK_EARRING },
    {    xi.items.TIMOROUS_VISION, xi.items.ENFEEBLING_EARRING },
    {   xi.items.VENERABLE_VISION,     xi.items.STRING_EARRING },
    {     xi.items.VIOLENT_VISION,    xi.items.BUCKLER_EARRING },
    {   xi.items.AUDACIOUS_VISION,     xi.items.DIVINE_EARRING },
    {   xi.items.ENDEARING_VISION,    xi.items.SINGING_EARRING },
    { xi.items.PUNCTILIOUS_VISION,   xi.items.PARRYING_EARRING },
    {      xi.items.VERNAL_VISION,    xi.items.EVASION_EARRING },
    {       xi.items.VIVID_VISION,    xi.items.HEALING_EARRING },
    {   xi.items.MALICIOUS_VISION,   xi.items.NINJUTSU_EARRING },
    { xi.items.PRETENTIOUS_VISION,  xi.items.ELEMENTAL_EARRING },
    {    xi.items.PRISTINE_VISION,       xi.items.WIND_EARRING },
    {      xi.items.SOLEMN_VISION,   xi.items.GUARDING_EARRING },
    {     xi.items.VALIANT_VISION, xi.items.AUGMENTING_EARRING },
    {   xi.items.IMPETUOUS_VISION,     xi.items.TOREADERS_RING },
    {     xi.items.TENUOUS_VISION,        xi.items.ASTRAL_ROPE },
    {       xi.items.SNIDE_VISION,      xi.items.SAFETY_MANTLE },
    {        xi.items.GRAVE_IMAGE,          xi.items.HABU_SKIN },
    {     xi.items.BEATIFIC_IMAGE,          xi.items.TIGER_EYE },
    {     xi.items.VALOROUS_IMAGE,    xi.items.RHEIYOH_LEATHER },
    {      xi.items.ANCIENT_IMAGE,     xi.items.OVERSIZED_FANG },
    {       xi.items.VIRGIN_IMAGE,      xi.items.SUPER_CERMENT },
}

entity.onTrade = function(player, npc, trade)
    local reward = 0

    -- Get what reward should be given according to traded item
    for _, prize in pairs(rewards) do
        if npcUtil.tradeHasExactly(trade, prize[1]) then
            reward = prize[2]
            player:setCharVar("veneReward", reward)
            player:startEvent(10066, reward)
        end
    end
end

entity.onTrigger = function(player, npc)
    -- Player has attempted the ENM at least once
    if
        player:getCurrentMission(xi.mission.log_id.COP) > xi.mission.id.cop.THE_RITES_OF_LIFE and
        player:getCharVar("[ENM]VenessaComplete") == 1
    then
        player:startEvent(10065)
    -- Player can do ENM but hasn't done it
    elseif player:getCurrentMission(xi.mission.log_id.COP) > xi.mission.id.cop.THE_RITES_OF_LIFE then
        player:startEvent(10064)
    -- Player has not progressed far enough in CoP
    else
        player:startEvent(10064, 99)
    end
end

entity.onEventUpdate = function(player, csid, option)
    local abandonmentTimer = player:getCharVar("[ENM]abandonmentTimer")
    local antipathyTimer = player:getCharVar("[ENM]antipathyTimer")
    local animusTimer = player:getCharVar("[ENM]animusTimer")
    local acrimonyTimer = player:getCharVar("[ENM]acrimonyTimer")

    if
        csid == 10064 or
        csid == 10065
    then
        -- Spit out time remaining on KI if on cooldown
        -- Spire of Holla ENM
        if
            option == 1 and VanadielTime() < abandonmentTimer and
            not player:hasKeyItem(xi.ki.CENSER_OF_ABANDONMENT)
        then
            player:updateEvent(1, 0, 0, 0, abandonmentTimer, 1, 0, 0)
        -- Spire of Dem ENM
        elseif
            option == 2 and VanadielTime() < antipathyTimer and
            not player:hasKeyItem(xi.ki.CENSER_OF_ANTIPATHY)
        then
            player:updateEvent(2, 0, 0, 0, antipathyTimer, 1, 0, 0)
        -- Spire of Mea ENM
        elseif
            option == 3 and VanadielTime() < animusTimer and
            not player:hasKeyItem(xi.ki.CENSER_OF_ANIMUS)
        then
            player:updateEvent(3, 0, 0, 0, animusTimer, 1, 0, 0)
        -- Spire of Vahzl ENM
        elseif
            option == 4 and VanadielTime() < acrimonyTimer and
            not player:hasKeyItem(xi.ki.CENSER_OF_ACRIMONY)
        then
            player:updateEvent(4, 0, 0, 0, acrimonyTimer, 1, 0, 0)
        end

        -- Cooldown is up, give player the KI
        -- Spire of Holla ENM
        if option == 1 and VanadielTime() >= abandonmentTimer then
            player:updateEvent(1, 0, 0, 1)
        -- Spire of Dem ENM
        elseif option == 2 and VanadielTime() >= antipathyTimer then
            player:updateEvent(2, 0, 0, 1)
        -- Spire of Mea ENM
        elseif option == 3 and VanadielTime() >= animusTimer then
            player:updateEvent(3, 0, 0, 1)
        -- Spire of Vahzl ENM
        elseif
            option == 4 and VanadielTime() >= acrimonyTimer and
            player:getCurrentMission(xi.mission.log_id.COP) > xi.mission.id.cop.SLANDEROUS_UTTERINGS
        then
            player:updateEvent(4, 0, 0, 1)
        end
    end
end

entity.onEventFinish = function(player, csid, option)
    -- Give player reward
    local objectTrade = player:getCharVar("veneReward")
    if csid == 10066 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, objectTrade)
        else
            player:tradeComplete()
            player:addItem(objectTrade)
            player:messageSpecial(ID.text.ITEM_OBTAINED, objectTrade)
            player:setCharVar("veneReward", 0)
        end
    end

    local abandonmentTimer = player:getCharVar("[ENM]abandonmentTimer")
    local antipathyTimer = player:getCharVar("[ENM]antipathyTimer")
    local animusTimer = player:getCharVar("[ENM]animusTimer")
    local acrimonyTimer = player:getCharVar("[ENM]acrimonyTimer")

    -- Give player KI
    if csid == 10065 or csid == 10064 then
        -- Spire of Holla ENM
        if
            option == 1 and os.time() >= abandonmentTimer and
            not player:hasKeyItem(xi.ki.CENSER_OF_ABANDONMENT)
        then
            npcUtil.giveKeyItem(player, xi.keyItem.CENSER_OF_ABANDONMENT)
            player:setCharVar("[ENM]abandonmentTimer", VanadielTime() + (xi.settings.main.ENM_COOLDOWN * 3600)) -- Current time + (ENM_COOLDOWN*1hr in seconds)
        -- Spire of Dem ENM
        elseif
            option == 2 and os.time() >= antipathyTimer and
            not player:hasKeyItem(xi.ki.CENSER_OF_ANTIPATHY)
        then
            npcUtil.giveKeyItem(player, xi.keyItem.CENSER_OF_ANTIPATHY)
            player:setCharVar("[ENM]antipathyTimer", VanadielTime() + (xi.settings.main.ENM_COOLDOWN * 3600)) -- Current time + (ENM_COOLDOWN*1hr in seconds)
        -- Spire of Mea ENM
        elseif
            option == 3 and os.time() >= animusTimer and
            not player:hasKeyItem(xi.ki.CENSER_OF_ANIMUS)
        then
            npcUtil.giveKeyItem(player, xi.keyItem.CENSER_OF_ANIMUS)
            player:setCharVar("[ENM]animusTimer", VanadielTime() + (xi.settings.main.ENM_COOLDOWN * 3600)) -- Current time + (ENM_COOLDOWN*1hr in seconds)
        -- Spire of Vahzl ENM
        elseif
            option == 4 and os.time() >= acrimonyTimer and
            not player:hasKeyItem(xi.ki.CENSER_OF_ACRIMONY)
        then
            npcUtil.giveKeyItem(player, xi.keyItem.CENSER_OF_ACRIMONY)
            player:setCharVar("[ENM]acrimonyTimer", VanadielTime() + (xi.settings.main.ENM_COOLDOWN * 3600)) -- Current time + (ENM_COOLDOWN*1hr in seconds)
        end
    end
end

return entity
