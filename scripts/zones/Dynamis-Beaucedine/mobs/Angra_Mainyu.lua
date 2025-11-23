-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Angra Mainyu
-- Note: Mega Boss
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobEngage = function(mob, target)
    local mobId = mob:getID()
    for i = mobId + 1, mobId + 4 do
        local m = GetMobByID(i)
        if m and not m:isSpawned() then
            SpawnMob(i)
        end
    end
end

entity.onMobFight = function(mob, target)
    local mobId = mob:getID()
    for i = mobId + 1, mobId + 4 do
        local pet = GetMobByID(i)
        if
            pet and
            pet:isSpawned() and
            pet:getCurrentAction() == xi.action.category.ROAMING
        then
            pet:updateEnmity(target)
        end
    end
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        xi.magic.spell.BLINDGA,
        xi.magic.spell.DEATH,
        xi.magic.spell.GRAVIGA,
        xi.magic.spell.SLEEPGA_II,
        xi.magic.spell.SILENCEGA,
    }

    if mob:getHPP() <= 25 then
        return xi.magic.spell.DEATH
    end

    return spellList[math.random(1, #spellList)]
end

entity.onMobDeath = function(mob, player, optParams)
    xi.dynamis.megaBossOnDeath(mob, player, optParams)
end

return entity
