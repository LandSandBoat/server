-----------------------------------
-- Area: Bibiki Bay
--  Mob: Shen
-----------------------------------
local entity = {}

entity.onMobFight = function(mob, target)
    if (mob:getBattleTime() % 45 == 0) then
        local mobId = mob:getID()
        for i = 1, 2 do
            if (not GetMobByID(mobId+i):isSpawned()) then
                SpawnMob(mobId+i):updateEnmity(target)
            end
        end
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMonsterMagicPrepare = function(mob, target)
    -- casts Water IV, Waterga III, Flood, Drown
    local rnd = math.random()

    if (rnd < 0.5) then
        return 201 -- waterga 3
    elseif (rnd < 0.7) then
        return 172 -- water 4
    elseif (rnd < 0.9) then
        return 214 -- flood
    else
        return 240 -- drown
    end

end

return entity
