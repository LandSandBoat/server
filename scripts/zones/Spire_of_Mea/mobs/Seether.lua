-----------------------------------
-- Area: Spire of Mea
--  Mob: Seether ("Pet" of Envier)
-----------------------------------
---@type TMobEntity
local entity = {}


entity.onMobSpawn = function(mob)
    mob:setLocalVar('initialAbility', 1)
end

entity.onMobEngage = function(mob, target) -- Seethers summoned by Envier immediately use an ability and spawn with HP based on Envier's current HP%, rounded up to the nearest 10%.
    local battlefield = mob:getBattlefield()
    if battlefield then
        local maxHP = mob:getMaxHP()

        local envierHPP = math.ceil(battlefield:getLocalVar('envierHPP') / 10) * 10
        envierHPP       = utils.clamp(envierHPP, 10, 100)

        local adjustedHP = math.floor(maxHP * envierHPP / 100)
        adjustedHP       = utils.clamp(adjustedHP, 1, maxHP)

        mob:setHP(adjustedHP)
    end

    if mob:getLocalVar('initialAbility') == 1 then
        mob:useMobAbility()
        mob:setLocalVar('initialAbility', 0)
    end
end

return entity
