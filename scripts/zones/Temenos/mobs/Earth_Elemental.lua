-----------------------------------
-- Area: Temenos E T
--  Mob: Earth Elemental
-----------------------------------
require("scripts/globals/limbus")
local ID = require("scripts/zones/Temenos/IDs")

function onMobDeath(mob, player, isKiller)
    if isKiller then
        local mobID = mob:getID()
        local mobX = mob:getXPos()
        local mobY = mob:getYPos()
        local mobZ = mob:getZPos()
        local battlefield = player:getBattlefield()
        if battlefield:getLocalVar("crateOpenedF4") ~= 1 then
            switch (mobID): caseof
            {
                [ID.mob.TEMENOS_E_MOB[4]] = function()
                    GetNPCByID(ID.npc.TEMENOS_E_CRATE[4]):setPos(mobX, mobY, mobZ)
                    tpz.limbus.spawnRandomCrate(ID.npc.TEMENOS_E_CRATE[4], player, "crateMaskF4", battlefield:getLocalVar("crateMaskF4"), true)
                end,
                [ID.mob.TEMENOS_E_MOB[4]+1] = function()
                    GetNPCByID(ID.npc.TEMENOS_E_CRATE[4]+1):setPos(mobX, mobY, mobZ)
                    tpz.limbus.spawnRandomCrate(ID.npc.TEMENOS_E_CRATE[4]+1, player, "crateMaskF4", battlefield:getLocalVar("crateMaskF4"), true)
                end,
                [ID.mob.TEMENOS_E_MOB[4]+2] = function()
                    GetNPCByID(ID.npc.TEMENOS_E_CRATE[4]+2):setPos(mobX, mobY, mobZ)
                    tpz.limbus.spawnRandomCrate(ID.npc.TEMENOS_E_CRATE[4]+2, player, "crateMaskF4", battlefield:getLocalVar("crateMaskF4"), true)
                end,
                [ID.mob.TEMENOS_E_MOB[4]+3] = function()
                    GetNPCByID(ID.npc.TEMENOS_E_CRATE[4]+3):setPos(mobX, mobY, mobZ)
                    tpz.limbus.spawnRandomCrate(ID.npc.TEMENOS_E_CRATE[4]+3, player, "crateMaskF4", battlefield:getLocalVar("crateMaskF4"), true)
                end,
                [ID.mob.TEMENOS_C_MOB[2]+6] = function()
                    GetMobByID(ID.mob.TEMENOS_C_MOB[2]):setMod(tpz.mod.EARTHDEF, -128)
                    if GetMobByID(ID.mob.TEMENOS_C_MOB[2]+7):isAlive() then
                        DespawnMob(ID.mob.TEMENOS_C_MOB[2]+7)
                        SpawnMob(ID.mob.TEMENOS_C_MOB[2]+13)
                    end
                end,
            }
        end
    end
end
