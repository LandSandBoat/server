-----------------------------------
-- Area: Mamook
--  Mob: Hundredfaced Hapool Ja
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.MAMOOK]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    -- only the main copy gets the listener
    if mob:getID() ~= ID.mob.HUNDRED_FACE_HAPOOL_JA then
        return
    end

    mob:addListener('MAGIC_USE', 'SPAWN_CLONES', function(mobArg, target, spell, action)
        local hundredfacedHapoolJa = ID.mob.HUNDRED_FACE_HAPOOL_JA
        local spellId              = spell:getID()
        local mainMob              = GetMobByID(hundredfacedHapoolJa)
        local hateTarget           = mainMob and mainMob:getTarget()

        -- Utsusemi: Ichi (3 clones)
        if hateTarget then
            if spellId == xi.magic.spell.UTSUSEMI_ICHI then
                for clone = hundredfacedHapoolJa + 1, hundredfacedHapoolJa + 3 do
                    local cloneMob = GetMobByID(clone)
                    if cloneMob and not cloneMob:isSpawned() then
                        cloneMob:setSpawn(mob:getXPos() + math.random(1, 5), mob:getYPos(), mob:getZPos() + math.random(1, 5))
                        SpawnMob(clone):updateEnmity(hateTarget)
                    end
                end

            -- Utsusemi: Ni/San (4 clones)
            elseif
                spellId == xi.magic.spell.UTSUSEMI_NI or
                spellId == xi.magic.spell.UTSUSEMI_SAN
            then
                for clone = hundredfacedHapoolJa + 1, hundredfacedHapoolJa + 4 do
                    local cloneMob = GetMobByID(clone)
                    if cloneMob and not cloneMob:isSpawned() then
                        cloneMob:setSpawn(mob:getXPos() + math.random(1, 5), mob:getYPos(), mob:getZPos() + math.random(1, 5))
                        SpawnMob(clone):updateEnmity(hateTarget)
                    end
                end
            end
        end

        for i = hundredfacedHapoolJa + 1, hundredfacedHapoolJa + 4 do
            local pet = GetMobByID(i)

            if pet and pet:getCurrentAction() == xi.action.category.ROAMING then
                pet:updateEnmity(target)
            end
        end
    end)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.SPECIAL_SKILL, 0)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
end

entity.onMobEngage = function(mob, target)
    -- Clone mobs cast a spell on engage
    if mob:getID() ~= ID.mob.HUNDRED_FACE_HAPOOL_JA then
        mob:castSpell()
    end
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    return xi.mobSkill.FIRESPIT
end

entity.onMobWeaponSkill = function(mob, target, skill, action)
    -- Clones queue a mob ability when the main one does
    if mob:getID() == ID.mob.HUNDRED_FACE_HAPOOL_JA then
        for i = 1, 4 do
            local clone = GetMobByID(ID.mob.HUNDRED_FACE_HAPOOL_JA + i)

            if clone then
                clone:useMobAbility()
            end
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if mob:getID() == ID.mob.HUNDRED_FACE_HAPOOL_JA then
        for i = 1, 4 do
            DespawnMob(ID.mob.HUNDRED_FACE_HAPOOL_JA + i)
        end
    end
end

entity.onMobDespawn = function(mob)
    if mob:getID() == ID.mob.HUNDRED_FACE_HAPOOL_JA then
        for i = 1, 4 do
            DespawnMob(ID.mob.HUNDRED_FACE_HAPOOL_JA + i)
        end
    end
end

return entity
