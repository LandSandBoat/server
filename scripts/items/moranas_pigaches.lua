-----------------------------------
-- ID: 11408
-- Morana Pigaches
-- Pet mod via latent effect
-----------------------------------
---@type TItem
local itemObject = {}
local listenerPrefix = 'PET_MOD_LATENT'
local latentPetId = xi.petId.SHIVA
local latentMods =
{
    { xi.mod.MACC, 6 },
}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemEquip  = function(user, item)
    local listenerName = fmt('{}_{}', listenerPrefix, item:getID())
    xi.itemUtils.handlePetLatentMods(user, latentPetId, latentMods, true)

    user:addListener('MAGIC_STATE_EXIT', listenerName, function(player, spell)
        if spell:getSpellGroup() == xi.magic.spellGroup.SUMMONING then
            xi.itemUtils.handlePetLatentMods(user, latentPetId, latentMods, true)
        end
    end)
end

itemObject.onItemUnequip = function(user, item)
    local listenerName = fmt('{}_{}', listenerPrefix, item:getID())
    xi.itemUtils.handlePetLatentMods(user, latentPetId, latentMods, false)

    user:removeListener(listenerName)
end

return itemObject
