-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Trion
-- Ally during San d'Oria Mission 9-2
-----------------------------------
local ID = zones[xi.zone.QUBIA_ARENA]
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.REGAIN, 30)
end

entity.onMobSpawn = function(mob)
    mob:addListener('WEAPONSKILL_STATE_ENTER', 'WS_START_MSG', function(mobArg, skillID)
        -- Red Lotus Blade
        if skillID == 968 then
            mobArg:showText(mobArg, ID.text.RLB_PREPARE)
        -- Flat Blade
        elseif skillID == 969 then
            mobArg:showText(mobArg, ID.text.FLAT_PREPARE)
        -- Savage Blade
        elseif skillID == 970 then
            mobArg:showText(mobArg, ID.text.SAVAGE_PREPARE)
        end
    end)
end

entity.onMobDisengage = function(mob)
end

entity.onMobRoam = function(mob)
    local wait = mob:getLocalVar('wait')
    if wait > 40 and not mob:getTarget() then
        local battlefieldArea = mob:getBattlefield():getArea()
        local mobOffset       = ID.mob.WARLORD_ROJGNOJ + (battlefieldArea - 1) * 14

        local livingMobs = {}
        for mobId = mobOffset, mobOffset + 2 do
            local target = GetMobByID(mobId)

            if
                target and
                target:isSpawned() and
                not target:isDead()
            then
                table.insert(livingMobs, target)
            end
        end

        local newTarget = livingMobs[math.random(1, #livingMobs)]
        mob:addEnmity(newTarget, 0, 1)
        mob:updateEnmity(newTarget)
    else
        mob:setLocalVar('wait', wait + 3)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    mob:getBattlefield():lose()
end

return entity
