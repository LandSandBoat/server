-----------------------------------
-- Area: Mamook
--  Mob: Hundredfaced Hapool Ja
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    local hundredfacedHapoolJa = mob:getID()
    mob:addListener('MAGIC_USE', 'SPAWN_CLONES', function(mobArg, target, spell, action)
        local spellId = spell:getID()
        local hateTarget = GetMobByID(hundredfacedHapoolJa):getTarget()

        -- Utsusemi: Ichi (3 clones)
        if spellId == xi.magic.spell.UTSUSEMI_ICHI then
            for clone = hundredfacedHapoolJa + 1, hundredfacedHapoolJa + 3 do
                if not GetMobByID(clone):isSpawned() then
                    GetMobByID(clone):setSpawn(mob:getXPos() + math.random(1, 5), mob:getYPos(), mob:getZPos() + math.random(1, 5))
                    SpawnMob(clone):updateEnmity(hateTarget)
                end
            end

        -- Utsusemi: Ni/San (4 clones)
        elseif
            spellId == xi.magic.spell.UTSUSEMI_NI or
            spellId == xi.magic.spell.UTSUSEMI_SAN
        then
            for clone = hundredfacedHapoolJa + 1, hundredfacedHapoolJa + 4 do
                if not GetMobByID(clone):isSpawned() then
                    GetMobByID(clone):setSpawn(mob:getXPos() + math.random(1, 5), mob:getYPos(), mob:getZPos() + math.random(1, 5))
                    SpawnMob(clone):updateEnmity(hateTarget)
                end
            end
        end

        for i = hundredfacedHapoolJa + 1, hundredfacedHapoolJa + 4 do
            local pet = GetMobByID(i)
            if pet:getCurrentAction() == xi.act.ROAMING then
                pet:updateEnmity(target)
            end
        end
    end)
end

entity.onMobEngaged = function(mob, target)
    mob:castSpell(xi.magic.spell.UTSUSEMI_SAN, mob)
end

entity.onMobDeath = function(mob, player, optParams)
    local hundredfacedHapoolJa = mob:getID()
    for i = 1, 4 do DespawnMob(hundredfacedHapoolJa + i) end
end

entity.onMobDespawn = function(mob)
    local hundredfacedHapoolJa = mob:getID()
    for i = 1, 4 do DespawnMob(hundredfacedHapoolJa + i) end
end

return entity
