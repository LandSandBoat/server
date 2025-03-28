-----------------------------------
-- Area: Phomiuna Aqueducts
--  Mob: Minotaur
-----------------------------------
mixins = { require('scripts/mixins/fomor_hate') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobFight = function(mob, target)
    local drawInTable =
    {
        conditions =
        {
            mob:checkDistance(target) >= 15,
        },
        position = mob:getPos(),
    }
    if drawInTable.conditions[1] then
        for _, member in ipairs(target:getAlliance()) do
            if member:getZone() == mob:getZone() then
                utils.drawIn(member, drawInTable)
            end
        end
    end
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('fomorHateAdj', 2)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
