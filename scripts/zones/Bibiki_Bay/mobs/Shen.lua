-----------------------------------
-- Area: Bibiki Bay
--  Mob: Shen
-----------------------------------
local ID = require("scripts/zones/Bibiki_Bay/IDs")
-----------------------------------
local entity = {}


entity.enterShell = function(mob)
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

entity.exitShell = function(mob)
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

entity.onMobSpawn = function(mob)
    mob:setLocalVar("enterTimer", os.time() + math.random(45,120))
    mob:setLocalVar("shellControl", 0)
    entity.exitShell(mob) -- encountered bug where if he was killed previously in shell
                               -- he would spawn in his shell. This corrected it.
end

entity.onMobFight = function(mob, target)
    if (os.time() > mob:getLocalVar("enterTimer") and mob:getLocalVar("shellControl") == 0) then
        entity.enterShell(mob)
        mob:setLocalVar("exitTimer", os.time() + math.random(45, 120))
        mob:setLocalVar("shellControl", 1)
    end

    if (os.time() > mob:getLocalVar("exitTimer") and mob:getLocalVar("shellControl") == 1) then
        entity.exitShell(mob)
        mob:setLocalVar("enterTimer", os.time() + math.random(45, 120))
        mob:setLocalVar("shellControl", 0)
    end

    entity.spawnFiltrate(mob, target)
end

entity.spawnFiltrate = function(mob, target)
    if (mob:getLocalVar("shellControl") == 1 and mob:getHP() > 0) then
        for i = 1, 2 do
            if (not GetMobByID(mob:getID()+i):isSpawned()) then
                SpawnMob(mob:getID()+i):updateEnmity(target)
            end
        end
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
