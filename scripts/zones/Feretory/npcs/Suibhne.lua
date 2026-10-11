-----------------------------------
-- Area: Feretory (285)
--  NPC: Suibhne
-- !pos -366 -3.612 -466 285
-----------------------------------
local ID = zones[xi.zone.FERETORY]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if xi.settings.main.ENABLE_MONSTROSITY ~= 1 then
        return
    end

    local data = player:getMonstrosityData()
    for idx, unlock in ipairs(xi.monstrosity.suibhneUnlocks) do
        for _, itemId in ipairs(unlock.items) do
            if
                xi.monstrosity.canSuibhneUnlock(data, unlock) and
                npcUtil.tradeMatches(trade, { { itemId, unlock.count } })
            then
                player:setLocalVar('SUIBHNE_TRADE', idx)
                player:startEvent(15, unlock.species and 128 + unlock.species or 256 + unlock.variant, itemId, unlock.count)

                return
            end
        end
    end
end

entity.onTrigger = function(player, npc)
    if xi.settings.main.ENABLE_MONSTROSITY ~= 1 then
        return
    end

    xi.monstrosity.suibhneGreet(player, npc)
    player:startEvent(11)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid ~= 15 then
        return
    end

    local unlock = xi.monstrosity.suibhneUnlocks[player:getLocalVar('SUIBHNE_TRADE')]
    player:setLocalVar('SUIBHNE_TRADE', 0)

    -- The client echoes the species code in the high word.
    if
        bit.band(option, 0xFFFF) ~= 2 or
        not unlock or
        not player:tradeComplete()
    then
        return
    end

    if unlock.species then
        xi.monstrosity.unlockSpecies(player, unlock.species)
    else
        xi.monstrosity.unlockVariant(player, unlock.variant)
    end

    player:showText(npc, ID.text.MAY_POSSESS_NEW_SPECIES)

    -- Retail takes a new variant's form at once, but not a new family's. A variant's species code is 256 plus its id.
    if unlock.variant then
        player:changeMonstrositySpecies(256 + unlock.variant)
    end
end

return entity
