-----------------------------------
-- Area: Temenos E T
--  Mob: Fire Elemental
-----------------------------------
require("scripts/globals/limbus")
local ID = require("scripts/zones/Temenos/IDs")

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local battlefield = mob:getBattlefield()
        if battlefield:getLocalVar("crateOpenedF1") ~= 1 then
            local mobX = mob:getXPos()
            local mobY = mob:getYPos()
            local mobZ = mob:getZPos()
            switch (mob:getID()): caseof
            {
                [ID.mob.TEMENOS_E_MOB[1]] = function()
                    GetNPCByID(ID.npc.TEMENOS_E_CRATE[1]):setPos(mobX, mobY, mobZ)
                    tpz.limbus.spawnRandomCrate(ID.npc.TEMENOS_E_CRATE[1], battlefield, "crateMaskF1", battlefield:getLocalVar("crateMaskF1"), true)
                end,
                [ID.mob.TEMENOS_E_MOB[1]+1] = function()
                    GetNPCByID(ID.npc.TEMENOS_E_CRATE[1]+1):setPos(mobX, mobY, mobZ)
                    tpz.limbus.spawnRandomCrate(ID.npc.TEMENOS_E_CRATE[1]+1, battlefield, "crateMaskF1", battlefield:getLocalVar("crateMaskF1"), true)
                end,
                [ID.mob.TEMENOS_E_MOB[1]+2] = function()
                    GetNPCByID(ID.npc.TEMENOS_E_CRATE[1]+2):setPos(mobX, mobY, mobZ)
                    tpz.limbus.spawnRandomCrate(ID.npc.TEMENOS_E_CRATE[1]+2, battlefield, "crateMaskF1", battlefield:getLocalVar("crateMaskF1"), true)
                end,
                [ID.mob.TEMENOS_E_MOB[1]+3] = function()
                    GetNPCByID(ID.npc.TEMENOS_E_CRATE[1]+3):setPos(mobX, mobY, mobZ)
                    tpz.limbus.spawnRandomCrate(ID.npc.TEMENOS_E_CRATE[1]+3, battlefield, "crateMaskF1", battlefield:getLocalVar("crateMaskF1"), true)
                end,
                [ID.mob.TEMENOS_C_MOB[2]+3] = function()
                    GetMobByID(ID.mob.TEMENOS_C_MOB[2]):setMod(tpz.mod.FIREDEF, -128)
                    if GetMobByID(ID.mob.TEMENOS_C_MOB[2]+4):isAlive() then
                        DespawnMob(ID.mob.TEMENOS_C_MOB[2]+4)
                        SpawnMob(ID.mob.TEMENOS_C_MOB[2]+10)
                    end
                end,
            }
        end
    end
end
