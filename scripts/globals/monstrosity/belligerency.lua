-----------------------------------
-- Monstrosity - Belligerency
-- Aengus flags a Monipulator for PvP in the three Belligerency zones.
-----------------------------------
xi = xi or {}
xi.monstrosity = xi.monstrosity or {}

-- JP wiki: a gladiator holding the writ is capped too, even if not looking for a fight.
xi.monstrosity.applyBelligerencyCap = function(player)
    local cap = xi.monstrosity.belligerencyCaps[player:getZoneID()]
    if not cap then
        return
    end

    local ID = zones[player:getZoneID()]
    if player:getBelligerencyFlag() then
        player:addStatusEffect(xi.effect.LEVEL_RESTRICTION, { power = cap, origin = player })
        player:messageSpecial(ID.text.ENTERED_BELLIGERENCY_CAP, cap)
        return
    end

    if not player:hasKeyItem(xi.keyItem.GLADIATORIAL_WRIT_OF_SUMMONS) then
        return
    end

    -- A gladiator's message also mentions the equipment. JP wiki: Gestation lasts 60 s under Belligerency.
    player:addStatusEffect(xi.effect.LEVEL_RESTRICTION, { power = cap, origin = player })
    player:messageSpecial(ID.text.ENTERED_BELLIGERENCY_GLADIATOR, cap)
    player:addStatusEffect(xi.effect.GESTATION,
    {
        duration = 60,
        tick     = 10,
        origin   = player,
        flag     = bit.bor(xi.effectFlag.INVISIBLE, xi.effectFlag.DEATH, xi.effectFlag.MAGIC_BEGIN, xi.effectFlag.ON_ZONE),
        silent   = true,
    })
end

xi.monstrosity.aengusOnTrigger = function(player, npc)
    if xi.settings.main.ENABLE_MONSTROSITY ~= 1 then
        return
    end

    -- Retail params 2-4 are stale from the previous event, and zero after another NPC's.
    local inBelligerency = player:getBelligerencyFlag() and 1 or 0
    player:startEvent(13, inBelligerency, player:getCurrency('infamy'))
end

xi.monstrosity.aengusOnEventFinish = function(player, csid, option, npc)
    if csid ~= 13 or option ~= 1 then
        return
    end

    local entering = not player:getBelligerencyFlag()
    player:setBelligerencyFlag(entering)

    local ID = zones[xi.zone.FERETORY]
    player:messageText(npc, entering and ID.text.SOUL_PINETH_FOR_MORE or ID.text.SAFE_FROM_MONIPULATORS, true, 2)
end
