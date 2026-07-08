-----------------------------------
-- Area: LaLoff Amphitheater
--  Mob: Ark Angel's Mandragora
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 70)
end

entity.onMobEngage = function(mob, target)
    local mobid = mob:getID()

    for member = mobid-3, mobid + 4 do
        local m = GetMobByID(member)
        if m and m:getCurrentAction() == xi.action.category.ROAMING then
            m:updateEnmity(target)
        end
    end
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [1] = { xi.magic.spell.QUAKE,  target, false, xi.action.type.DAMAGE_TARGET,     nil,            0, 100 },
        [2] = { xi.magic.spell.SLOW,   target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.SLOW, 4, 100 },
        [3] = { xi.magic.spell.BINDGA, target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.BIND, 0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

return entity
