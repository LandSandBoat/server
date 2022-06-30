-----------------------------------
-- Area: Bibiki Bay
--  Mob: Shen
-----------------------------------
local ID = require("scripts/zones/Bibiki_Bay/IDs")
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> d89bd8e0c7f96ba5ea55d287d53186d48382f052
require("scripts/globals/mixins/families/uragnite")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
end

entity.onMobFight = function(mob, target)
<<<<<<< HEAD
=======
=======
require("scripts/globals/mixins/families/uragnite")
>>>>>>> 1584f53c9b (Including Uragnite mixin)
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
end

entity.onMobFight = function(mob, target)
<<<<<<< HEAD
    local enterShell = function()
        mob:setAnimationSub(1)
        mob:SetAutoAttackEnabled(false)
        mob:SetMagicCastingEnabled(false)
        mob:setMod(xi.mod.REGEN,        120)
        mob:setMod(xi.mod.UDMGPHYS,   -9000)
        mob:setMod(xi.mod.UDMGRANGE,  -9000)
        mob:setMod(xi.mod.UDMGMAGIC,  -6000)
        mob:setMod(xi.mod.UDMGBREATH, -6000)
        mob:setMobMod(xi.mobMod.NO_MOVE,  1)
    end

    local exitShell = function()
        mob:setAnimationSub(0)
        mob:SetAutoAttackEnabled(true)
        mob:SetMagicCastingEnabled(true)
        mob:setMod(xi.mod.REGEN,         0)
        mob:setMod(xi.mod.UDMGPHYS,      0)
        mob:setMod(xi.mod.UDMGRANGE,     0)
        mob:setMod(xi.mod.UDMGMAGIC,     0)
        mob:setMod(xi.mod.UDMGBREATH,    0)
        mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    end

    if os.time() > mob:getLocalVar("enterTimer") and mob:getLocalVar("shellControl") == 0 then
        enterShell()
        mob:setLocalVar("exitTimer", os.time() + math.random(45, 120))
        mob:setLocalVar("shellControl", 1)
    end

    if os.time() > mob:getLocalVar("exitTimer") and mob:getLocalVar("shellControl") == 1 then
        exitShell()
        mob:setLocalVar("enterTimer", os.time() + math.random(45, 120))
        mob:setLocalVar("shellControl", 0)
    end

>>>>>>> 31cae545dc (Shen Overhaul)
=======
>>>>>>> 1584f53c9b (Including Uragnite mixin)
=======
>>>>>>> d89bd8e0c7f96ba5ea55d287d53186d48382f052
    entity.spawnFiltrate(mob, target)
end

entity.spawnFiltrate = function(mob, target)
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
    if mob:getAnimationSub() == 1 and mob:getHP() > 0 then
        for i = 1, 2 do
            if not GetMobByID(mob:getID()+i):isSpawned() then
=======
    if (mob:getLocalVar("shellControl") == 1 and mob:getHP() > 0) then
=======
    if mob:getLocalVar("shellControl") == 1 and mob:getHP() > 0 then
>>>>>>> aa56f67b8c (Update Shen.lua)
        for i = 1, 2 do
            if (not GetMobByID(mob:getID()+i):isSpawned()) then
>>>>>>> 31cae545dc (Shen Overhaul)
=======
    if mob:getAnimationSub() == 1 and mob:getHP() > 0 then
        for i = 1, 2 do
            if not GetMobByID(mob:getID()+i):isSpawned() then
>>>>>>> 1584f53c9b (Including Uragnite mixin)
=======
    if mob:getAnimationSub() == 1 and mob:getHP() > 0 then
        for i = 1, 2 do
            if not GetMobByID(mob:getID()+i):isSpawned() then
>>>>>>> d89bd8e0c7f96ba5ea55d287d53186d48382f052
                SpawnMob(mob:getID()+i):updateEnmity(target)
            end
        end
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
