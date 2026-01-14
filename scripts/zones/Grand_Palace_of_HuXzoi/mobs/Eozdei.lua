-----------------------------------
-- Area: Grand Palace of Hu'Xzoi
--  Mob: Eo'zdei
-----------------------------------
mixins = { require('scripts/mixins/families/zdei') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onPath = function(mob)
    local spawnPos = mob:getSpawnPos()
    mob:pathThrough({ spawnPos.x, spawnPos.y, spawnPos.z })
    local pos = mob:getPos()
    if spawnPos.x == pos.x and spawnPos.z == pos.z then
        local rotOffset = mob:getLocalVar('zdeiRotationOffset')
        mob:setPos(spawnPos.x, spawnPos.y, spawnPos.z, mob:getRotPos() + rotOffset)
    end
end

entity.onMobMobskillChoose = function(mob, target)
    local form = mob:getAnimationSub()
    local tpMoves = { xi.mobSkill.REACTOR_COOL }

    switch (form): caseof
    {
        [1] = function()
            if math.random(1, 100) <= 75 then
                table.insert(tpMoves, xi.mobSkill.OPTIC_INDURATION_CHARGE)
            end
        end,

        [2] = function()
            table.insert(tpMoves, xi.mobSkill.STATIC_FILAMENT)
            table.insert(tpMoves, xi.mobSkill.DECAYED_FILAMENT)
        end,

        [3] = function()
            table.insert(tpMoves, xi.mobSkill.REACTOR_OVERLOAD)
            table.insert(tpMoves, xi.mobSkill.REACTOR_OVERHEAT)
        end,
    }

    return tpMoves[math.random(1, #tpMoves)]
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
