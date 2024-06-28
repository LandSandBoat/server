-----------------------------------
-- ID: 15528
-- Sacrifice Torque
-- Pet mod via latent effect
-- Latents are added to player before OnItemEquip is called
-- Latents are removed from player before OnItemUnequip is called
-----------------------------------
local itemObject = {}
local listenerPrefix = 'PET_MOD_LATENT'
local latentPetId = nil
local latentMods =
{
    { xi.mod.ATT, 3 },
}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemEquip  = function(user, item)
    local listenerName = fmt('{}_{}', listenerPrefix, item:getID())
    if user:hasAllLatentsActive(xi.slot.NECK) then
        user:setLocalVar(listenerName, 1)
        xi.itemUtils.handlePetLatentMods(user, latentPetId, latentMods, true)
    end

    user:addListener('MAGIC_STATE_EXIT', listenerName, function(player, spell)
        if spell:getSpellGroup() == xi.magic.spellGroup.SUMMONING then
            player:setLocalVar(listenerName, 1)
            xi.itemUtils.handlePetLatentMods(user, latentPetId, latentMods, true)
        end
    end)
end

itemObject.onItemUnequip = function(user, item)
    local listenerName = fmt('{}_{}', listenerPrefix, item:getID())
    if user:getLocalVar(listenerName) == 1 then
        xi.itemUtils.handlePetLatentMods(user, latentPetId, latentMods, false)
    end

    user:setLocalVar(listenerName, 0)
    user:removeListener(listenerName)
end

return itemObject
