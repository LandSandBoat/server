-----------------------------------
-- Area: Temenos E T
--  Mob: Water Elemental
-----------------------------------
require("scripts/globals/limbus")
local ID = require("scripts/zones/Temenos/IDs")

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local battlefield = mob:getBattlefield()
        if battlefield:getLocalVar("crateOpenedF6") ~= 1 then
            local mobX = mob:getXPos()
            local mobY = mob:getYPos()
            local mobZ = mob:getZPos()
            switch (mob:getID()): caseof
            {
                [ID.mob.TEMENOS_E_MOB[6]] = function()
                    GetNPCByID(ID.npc.TEMENOS_E_CRATE[6]):setPos(mobX, mobY, mobZ)
                    tpz.limbus.spawnRandomCrate(ID.npc.TEMENOS_E_CRATE[6], battlefield, "crateMaskF6", battlefield:getLocalVar("crateMaskF6"), true)
                end,
                [ID.mob.TEMENOS_E_MOB[6]+1] = function()
                    GetNPCByID(ID.npc.TEMENOS_E_CRATE[6]+1):setPos(mobX, mobY, mobZ)
                    tpz.limbus.spawnRandomCrate(ID.npc.TEMENOS_E_CRATE[6]+1, battlefield, "crateMaskF6", battlefield:getLocalVar("crateMaskF6"), true)
                end,
                [ID.mob.TEMENOS_E_MOB[6]+2] = function()
                    GetNPCByID(ID.npc.TEMENOS_E_CRATE[6]+2):setPos(mobX, mobY, mobZ)
                    tpz.limbus.spawnRandomCrate(ID.npc.TEMENOS_E_CRATE[6]+2, battlefield, "crateMaskF6", battlefield:getLocalVar("crateMaskF6"), true)
                end,
                [ID.mob.TEMENOS_E_MOB[6]+3] = function()
                    GetNPCByID(ID.npc.TEMENOS_E_CRATE[6]+3):setPos(mobX, mobY, mobZ)
                    tpz.limbus.spawnRandomCrate(ID.npc.TEMENOS_E_CRATE[6]+3, battlefield, "crateMaskF6", battlefield:getLocalVar("crateMaskF6"), true)
                end,
                [ID.mob.TEMENOS_C_MOB[2]+8] = function()
                    GetMobByID(ID.mob.TEMENOS_C_MOB[2]):setMod(tpz.mod.WATERDEF, -128)
                    if GetMobByID(ID.mob.TEMENOS_C_MOB[2]+3):isAlive() then
                        DespawnMob(ID.mob.TEMENOS_C_MOB[2]+3)
                        SpawnMob(ID.mob.TEMENOS_C_MOB[2]+9)
                    end
                end,
            }
        end
    end
end
