-----------------------------------
-- Monstrosity - Belligerency
-- Aengus flags a Monipulator for PvP in the three Belligerency zones.
-----------------------------------
require('scripts/globals/monstrosity/constants')
-----------------------------------
xi = xi or {}
xi.monstrosity = xi.monstrosity or {}

-- JP wiki: a gladiator holding the writ is capped too, even if not looking for a fight.
xi.monstrosity.applyBelligerencyCap = function(player)
    local cap = xi.monstrosity.belligerencyCaps[player:getZoneID()]
    if
        cap and
        (player:getBelligerencyFlag() or player:hasKeyItem(xi.keyItem.GLADIATORIAL_WRIT_OF_SUMMONS))
    then
        player:addStatusEffect(xi.effect.LEVEL_RESTRICTION, { power = cap, origin = player })
        player:messageSpecial(zones[player:getZoneID()].text.ENTERED_BELLIGERENCY_CAP, cap)
    end
end

xi.monstrosity.aengusOnTrigger = function(player, npc)
    if xi.settings.main.ENABLE_MONSTROSITY ~= 1 then
        return
    end

    -- TODO: Params 2-4 are 16780449, 142404 and 2 on retail. Their meaning is unknown.
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
