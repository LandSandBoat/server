-----------------------------------
-- ID: 11675
-- Fervor Ring
-- Pet mod via latent effect
-----------------------------------
local itemObject = {}
local listenerName = 'PET_MOD_LATENT_11675'
local latentPetId = xi.petId.IFRIT
local latentMods =
{
    { xi.mod.MATT, 2 },
}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemEquip  = function(user, item)
    xi.itemUtils.handlePetLatentMods(user, latentPetId, latentMods, true)

    user:addListener('MAGIC_STATE_EXIT', listenerName, function(player, spell)
        if
            spell:getSpellGroup() == xi.magic.spellGroup.SUMMONING
        then
            xi.itemUtils.handlePetLatentMods(user, latentPetId, latentMods, true)
        end
    end)
end

itemObject.onItemUnequip = function(user, item)
    xi.itemUtils.handlePetLatentMods(user, latentPetId, latentMods, false)

    user:removeListener(listenerName)
end

return itemObject
