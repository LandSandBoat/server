-----------------------------------
-- Salvage: Setting up Instances.
-----------------------------------
xi = xi or {}
xi.salvage = xi.salvage or {}

xi.salvage.onTrigger = function(player, npc, salvageZone)
    local ID = zones[player:getZoneID()]

    if player:hasKeyItem(xi.ki.REMNANTS_PERMIT) then
        xi.instance.onTrigger(player, npc, salvageZone)
    else
        player:messageSpecial(ID.text.NOTHING_HAPPENS)
    end
end

xi.salvage.onEventUpdate = function(player, csid, option, npc)
    local ID = zones[player:getZoneID()]

    for _, member in pairs(player:getAlliance()) do
        if not member:hasKeyItem(xi.ki.REMNANTS_PERMIT) then
            player:messageText(npc, ID.text.MEMBER_NO_REQS, false)
            player:instanceEntry(npc, 1)
            return
        end

        if member:checkImbuedItems() then
            if member:getID() == player:getID() then
                player:messageText(npc, ID.text.IMBUED_ITEM, false)
            else
                player:messageText(npc, ID.text.MEMBER_IMBUED_ITEM, false)
            end

            player:instanceEntry(npc, 1)
            return
        end
    end

    xi.instance.onEventUpdate(player, csid, option, npc)
end

-- Requirements for the first player registering the instance
xi.salvage.registryRequirements = function(player)
    local alliance = player:getAlliance()

    if #alliance < xi.settings.main.SALVAGE_MINIMUM_MEMBER_REQ then
        return false
    end

    return player:getMainLvl() >= 65 and player:hasKeyItem(xi.ki.REMNANTS_PERMIT)
end

-- Requirements for further players entering an already-registered instance
xi.salvage.entryRequirements = function(player)
    local alliance = player:getAlliance()

    if #alliance < xi.settings.main.SALVAGE_MINIMUM_MEMBER_REQ then
        return false
    end

    return player:getMainLvl() >= 65 and player:hasKeyItem(xi.ki.REMNANTS_PERMIT)
end

-- When the player zones into the instance
xi.salvage.afterInstanceRegister = function(player, fireFlies)
    local instance = player:getInstance()
    local ID = zones[player:getZoneID()]

    for i = xi.slot.MAIN, xi.slot.BACK do
        player:unequipItem(i)
    end

    player:messageSpecial(ID.text.TIME_TO_COMPLETE, instance:getTimeLimit())
    player:messageSpecial(ID.text.SALVAGE_START, 1)
    player:addStatusEffect(xi.effect.ENCUMBRANCE_I, { power = 65535, duration = 6000, origin = player })
    player:addStatusEffect(xi.effect.OBLIVISCENCE,  { power = 1,     duration = 6000, origin = player })
    player:addStatusEffect(xi.effect.OMERTA,        { power = 63,    duration = 6000, origin = player })
    player:addStatusEffect(xi.effect.IMPAIRMENT,    { power = 3,     duration = 6000, origin = player })
    player:addStatusEffect(xi.effect.DEBILITATION,  { power = 511,   duration = 6000, origin = player })
    player:addTempItem(fireFlies)
    player:delKeyItem(xi.ki.REMNANTS_PERMIT)
    player:messageSpecial(ID.text.TEMP_ITEM, fireFlies)
end

xi.salvage.onFailure = function(instance)
    local chars = instance:getChars()
    local mobs  = instance:getMobs()

    for _, mob in pairs(mobs) do
        DespawnMob(mob:getID(), instance)
    end

    if #chars > 0 then
        for _, player in ipairs(chars) do
            local ID = zones[player:getZoneID()]
            player:messageSpecial(ID.text.MISSION_FAILED, 10, 10)
            player:startCutscene(1)
        end
    end
end
