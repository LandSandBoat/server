-----------------------------------
-- Area: Sacrarium
--  Mob: Lobais
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

local pets = {288, 289, 290, 291, 291}

entity.onMobFight = function(mob, target)
    -- Manually casting pet as mob also casts BLM spells
    local pet = GetMobByID(mob:getID() + 1)
    if not pet:isSpawned() and mob:canUseAbilities() then
        local ele = math.random(1, #pets)
        mob:castSpell(pets[ele], mob)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
