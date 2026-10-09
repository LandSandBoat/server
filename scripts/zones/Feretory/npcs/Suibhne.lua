-----------------------------------
-- Area: Feretory (285)
--  NPC: Suibhne
-- !pos -366 -3.612 -466 285
-----------------------------------
local ID = zones[xi.zone.FERETORY]
-----------------------------------
---@type TNpcEntity
local entity = {}

-- Seasonal items Suibhne takes for a family or variant. Event 15 names the unlock as 128 plus a family, or 256 plus a variant.
local tradeUnlocks =
{
    [xi.item.SLIME_FETISH  ] = { species = xi.monstrositySpecies.ASTOLTIAN_SLIME     },
    [xi.item.AKE_OME_SPIRIT] = { variant = xi.monstrosityVariant.NEW_YEAR_MANDRAGORA },
}

entity.onTrade = function(player, npc, trade)
    if xi.settings.main.ENABLE_MONSTROSITY ~= 1 then
        return
    end

    for itemId, unlock in pairs(tradeUnlocks) do
        if npcUtil.tradeMatches(trade, { { itemId, 1 } }) then
            local owned = false
            if unlock.species then
                owned = xi.monstrosity.hasUnlockedSpecies(player, unlock.species)
            else
                owned = xi.monstrosity.hasUnlockedVariant(player, unlock.variant)
            end

            if not owned then
                player:setLocalVar('SUIBHNE_TRADE', itemId)
                player:startEvent(15, unlock.species and 128 + unlock.species or 256 + unlock.variant, itemId, 1)
            end

            return
        end
    end
end

entity.onTrigger = function(player, npc)
    if xi.settings.main.ENABLE_MONSTROSITY ~= 1 then
        return
    end

    player:showText(npc, ID.text.SINKING_THY_CLAWS)
    player:startEvent(11)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid ~= 15 then
        return
    end

    local unlock = tradeUnlocks[player:getLocalVar('SUIBHNE_TRADE')]
    player:setLocalVar('SUIBHNE_TRADE', 0)

    if
        option ~= 2 or
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

    player:messageSpecial(ID.text.MAY_POSSESS_NEW_SPECIES)
end

return entity
