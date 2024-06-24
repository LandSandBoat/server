-----------------------------------
-- ID: 11496
-- Fenrir's Crown
-- Pet mod via latent effect
-----------------------------------
local itemObject = {}
local listenerPrefix = 'PET_MOD_LATENT'
local latentPetId = xi.petId.FENRIR
local latentMods =
{
    { xi.mod.ACC, 5 },
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
