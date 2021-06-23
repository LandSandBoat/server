-----------------------------------
-- Trust
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/common")
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/roe")
-----------------------------------

xi = xi or {}
xi.trust = xi.trust or {}

xi.trust.message_offset =
{
    SPAWN          = 1,
    TEAMWORK_1     = 4,
    TEAMWORK_2     = 5,
    TEAMWORK_3     = 6,
    TEAMWORK_4     = 7,
    TEAMWORK_5     = 8,
    DEATH          = 9,
    DESPAWN        = 11,
    SPECIAL_MOVE_1 = 18,
}

local MAX_MESSAGE_PAGE = 121

local rovKIBattlefieldIDs = set{
    5,    -- Shattering Stars (WAR LB5)
    6,    -- Shattering Stars (BLM LB5)
    7,    -- Shattering Stars (RNG LB5)
    70,   -- Shattering Stars (RDM LB5)
    71,   -- Shattering Stars (THF LB5)
    72,   -- Shattering Stars (BST LB5)
    101,  -- Shattering Stars (MNK LB5)
    102,  -- Shattering Stars (WHM LB5)
    103,  -- Shattering Stars (SMN LB5)
    163,  -- Survival of the Wisest (SCH LB5)
    194,  -- Shattering Stars (SAM LB5)
    195,  -- Shattering Stars (NIN LB5)
    196,  -- Shattering Stars (DRG LB5)
    517,  -- Shattering Stars (PLD LB5)
    518,  -- Shattering Stars (DRK LB5)
    519,  -- Shattering Stars (BRD LB5)
    530,  -- A Furious Finale (DNC LB5)
    1091, -- Breaking the Bonds of Fate (COR LB5)
    1123, -- Achieving True Power (PUP LB5)
    1154, -- The Beast Within (BLU LB5)
-- TODO: GEO LB5
-- TODO: RUN LB5
}

-- NOTE: Unfortunately, these are not linear, so we have to use
--       a big lookup of offsets instead of a single offset
local poolIDToMessagePageOffset = {
    [5896] = 0,   -- Shantotto
    [5897] = 1,   -- Naji
    [5898] = 2,   -- Kupipi
    [5899] = 3,   -- Excenmille
    [5900] = 4,   -- Ayame
    [5901] = 5,   -- Nanaa Mihgo
    [5902] = 6,   -- Curilla
    [5903] = 7,   -- Volker
    [5904] = 8,   -- Ajido-Marujido
    [5905] = 9,   -- Trion
    [5906] = 10,  -- Zeid
    [5907] = 11,  -- Lion
    [5908] = 12,  -- Tenzen
    [5909] = 13,  -- Mihli Aliapoh
    [5910] = 14,  -- Valaineral
    [5911] = 15,  -- Joachim
    [5912] = 16,  -- Naja Salaheem
    [5913] = 17,  -- Prishe
    [5914] = 18,  -- Ulmia
    [5915] = 19,  -- Shikaree Z
    [5916] = 20,  -- Cherukiki
    [5917] = 21,  -- Iron Eater
    [5918] = 22,  -- Gessho
    [5919] = 23,  -- Gadalar
    [5920] = 24,  -- Rainemard
    [5921] = 25,  -- Ingrid
    [5922] = 26,  -- Lehko Habhoka
    [5923] = 27,  -- Nashmeira
    [5924] = 28,  -- Zazarg
    [5925] = 29,  -- Ovjang
    [5926] = 30,  -- Mnejing
    [5927] = 31,  -- Sakura
    [5928] = 32,  -- Luzaf
    [5929] = 33,  -- Najelith
    [5930] = 34,  -- Aldo
    [5931] = 35,  -- Moogle
    [5932] = 36,  -- Fablinix
    [5933] = 37,  -- Maat
    [5934] = 38,  -- D.Shantotto
    [5935] = 39,  -- Star Sibyl
    [5936] = 40,  -- Karaha-Baruha
    [5937] = 41,  -- Cid
    [5938] = 42,  -- Gilgamesh
    [5939] = 43,  -- Areuhat
    [5940] = 44,  -- Semih Lafihna
    [5941] = 45,  -- Elivira
    [5942] = 46,  -- Noillurie
    [5943] = 47,  -- Lhu Mhakaracca
    [5944] = 48,  -- Ferreous Coffi
    [5945] = 49,  -- Lilisette
    [5946] = 50,  -- Mumor
    [5947] = 51,  -- Uka Totlihn
    [5948] = 53,  -- Klara
    [5949] = 54,  -- Romaa Mihgo
    [5950] = 55,  -- Kuyin Hathdenna
    [5951] = 56,  -- Rahal
    [5952] = 57,  -- Koru-Moru
    [5953] = 58,  -- Pieuje UC
    [5954] = 60,  -- I.Shield UC
    [5955] = 61,  -- Apururu UC
    [5956] = 62,  -- Jakoh UC
    [5957] = 59,  -- Flaviria UC
    [5958] = 67,  -- Babban
    [5959] = 68,  -- Abenzio
    [5960] = 69,  -- Rughadjeen
    [5961] = 70,  -- Kukki-Chebukki
    [5962] = 71,  -- Margret
    [5963] = 72,  -- Chacharoon
    [5964] = 73,  -- Lhe Lhangavo
    [5965] = 74,  -- Arciela
    [5966] = 75,  -- Mayakov
    [5967] = 76,  -- Qultada
    [5968] = 77,  -- Adelheid
    [5969] = 78,  -- Amchuchu
    [5970] = 79,  -- Brygid
    [5971] = 80,  -- Mildaurion
    [5972] = 87,  -- Halver
    [5973] = 88,  -- Rongelouts
    [5974] = 89,  -- Leonoyne
    [5975] = 90,  -- Maximilian
    [5976] = 91,  -- Kayeel-Payeel
    [5977] = 92,  -- Robel-Akbel
    [5978] = 93,  -- Kupofried
    [5979] = 94,  -- Selhteus
    [5980] = 95,  -- Yoran-Oran UC
    [5981] = 96,  -- Sylvie UC
    [5982] = 98,  -- Abquhbah
    [5983] = 99,  -- Balamor
    [5984] = 100, -- August
    [5985] = 101, -- Rosulatia
    [5986] = 103, -- Teodor
    [5987] = 105, -- Ullegore
    [5988] = 106, -- Makki-Chebukki
    [5989] = 107, -- King of Hearts
    [5990] = 108, -- Morimar
    [5991] = 109, -- Darrcuiln
    [5992] = 113, -- ArkHM
    [5993] = 114, -- ArkEV
    [5994] = 115, -- ArkMK
    [5995] = 116, -- ArkTT
    [5996] = 117, -- ArkGK
    [5997] = 110, -- Iroha
    [5998] = 118, -- Ygnas
    [5999] = 120, -- Monberaux
    [6004] = 52,  -- Excenmille [S]
    [6005] = 63,  -- Ayame UC
    [6006] = 64,  -- Maat UC
    [6007] = 65,  -- Aldo UC
    [6008] = 66,  -- Naja UC
    [6009] = 81,  -- Lion II
    [6010] = 86,  -- Zeid II
    [6011] = 82,  -- Prishe II
    [6012] = 83,  -- Nashmeira II
    [6013] = 84,  -- Lilisette II
    [6014] = 97,  -- Tenzen II
    [6015] = 104, -- Mumor II
    [6016] = 102, -- Ingrid II
    [6017] = 85,  -- Arciela II
    [6018] = 111, -- Iroha II
    [6019] = 112, -- Shantotto II
}

xi.trust.onTradeCipher = function(player, trade, csid, rovCs, arkAngelCs)
    local hasPermit = player:hasKeyItem(xi.ki.WINDURST_TRUST_PERMIT) or
                      player:hasKeyItem(xi.ki.BASTOK_TRUST_PERMIT) or
                      player:hasKeyItem(xi.ki.SAN_DORIA_TRUST_PERMIT)

    local itemId = trade:getItemId(0)
    local subId = trade:getItemSubId(0)
    local isCipher = itemId >= 10112 and itemId <= 10193

    if hasPermit and trade:getSlotCount() == 1 and subId ~= 0 and isCipher then
        -- subId is a smallInt in the database (16 bits).
        -- The bottom 12 bits of the subId are the spellId taught by the ciper
        -- The top 4 bits of the subId are for the flags to be given to the csid
        local spellId = bit.band(subId, 0x0FFF)
        local flags = bit.rshift(bit.band(subId, 0xF000), 12)

        -- To generate this packed subId for storage in the db:
        -- local encoded = spellId + bit.lshift(flags, 12)

        -- Cipher type cs args (Wetata's text as example):
        -- 0 (add 0)    : Did you know that the person mentioned here is also a participant in the Trust initiative?
        --                All the stuffiest scholars... (Default)
        -- 1 (add 4096) : Wait a second... just who is that? How am I supposed to use <cipher> in conditions like these? (WOTG)
        -- 2 (add 8192) : You may be shocked to hear that there are trusts beyond the five races (Beasts & Monsters)
        -- 3 (add 12288): How on earth did you get your hands on this? If it's a real cipher I have to try! (Special)
        -- 4 (add 16384): Progressed leaps and bounds. You and that person must have something truly special-wecial going on between you.
        --                (Mainline story princesses and II trust versions??)

        player:setLocalVar("TradingTrustCipher", spellId)

        -- TODO Blocking for ROV ciphers
        local rovBlock = false
        local arkAngelCipher = itemId >= 10188 and itemId <= 10192

        if rovBlock then
            player:startEvent(rovCs)
        elseif arkAngelCipher then
            player:startEvent(arkAngelCs, 0, 0, 0, itemId)
        else
            player:startEvent(csid, 0, 0, flags, itemId)
        end
    end
end

xi.trust.canCast = function(caster, spell, not_allowed_trust_ids)
    -- Trusts must be enabled in settings
    if ENABLE_TRUST_CASTING == 0 then
        return xi.msg.basic.TRUST_NO_CAST_TRUST
    end

    -- Trusts not allowed in an alliance
    if caster:checkSoloPartyAlliance() == 2 then
        return xi.msg.basic.TRUST_NO_CAST_TRUST
    end

    -- Trusts only allowed in certain zones (Remove this for trusts everywhere)
    if not caster:canUseMisc(xi.zoneMisc.TRUST) then
        return xi.msg.basic.TRUST_NO_CALL_AE
    end

    -- You can only summon trusts if you are the party leader or solo
    local leader = caster:getPartyLeader()
    if leader and caster:getID() ~= leader:getID() then
        caster:messageSystem(xi.msg.system.TRUST_SOLO_OR_LEADER)
        return -1
    end

    -- Block summoning trusts if seeking a party
    if caster:isSeekingParty() then
        caster:messageSystem(xi.msg.system.TRUST_NO_SEEKING_PARTY)
        return -1
    end

    -- Block summoning trusts if someone recently joined party (120s)
    local last_party_member_added_time = caster:getPartyLastMemberJoinedTime()
    if os.time() - last_party_member_added_time < 120 then
        caster:messageSystem(xi.msg.system.TRUST_DELAY_NEW_PARTY_MEMBER)
        return -1
    end

    -- Trusts cannot be summoned if you have hate
    if caster:hasEnmity() then
        caster:messageSystem(xi.msg.system.TRUST_NO_ENMITY)
        return -1
    end

    -- Check party for trusts
    local num_pt = 0
    local num_trusts = 0
    local party = caster:getPartyWithTrusts()
    for _, member in pairs(party) do
        if member:getObjType() == xi.objType.TRUST then
            -- Check for same trust
            if member:getTrustID() == spell:getID() then
                caster:messageSystem(xi.msg.system.TRUST_ALREADY_CALLED)
                return -1
            -- Check not allowed trust combinations (Shantotto I vs Shantotto II)
            elseif type(not_allowed_trust_ids) == "number" then
                if member:getTrustID() == not_allowed_trust_ids then
                    caster:messageSystem(xi.msg.system.TRUST_ALREADY_CALLED)
                    return -1
                end
            elseif type(not_allowed_trust_ids) == "table" then
                for _, v in pairs(not_allowed_trust_ids) do
                    if type(v) == "number" then
                        if member:getTrustID() == v then
                            caster:messageSystem(xi.msg.system.TRUST_ALREADY_CALLED)
                            return -1
                        end
                    end
                end
            end
            num_trusts = num_trusts + 1
        end
        num_pt = num_pt + 1
    end

    -- Max party size
    if num_pt >= 6 then
        caster:messageSystem(xi.msg.system.TRUST_MAXIMUM_NUMBER)
        return -1
    end

    -- Some battlefields allow trusts after you get this ROV Key Item
    local casterBattlefieldID = caster:getBattlefieldID()
    if rovKIBattlefieldIDs[casterBattlefieldID] and not caster:hasKeyItem(xi.ki.RHAPSODY_IN_UMBER) then
        return xi.msg.basic.TRUST_NO_CAST_TRUST
    end

    -- Limits set by ROV Key Items
    if num_trusts >= 3 and not caster:hasKeyItem(xi.ki.RHAPSODY_IN_WHITE) then
        caster:messageSystem(xi.msg.system.TRUST_MAXIMUM_NUMBER)
        return -1
    elseif num_trusts >= 4 and not caster:hasKeyItem(xi.ki.RHAPSODY_IN_CRIMSON) then
        caster:messageSystem(xi.msg.system.TRUST_MAXIMUM_NUMBER)
        return -1
    end

    return 0
end

xi.trust.spawn = function(caster, spell)
    caster:spawnTrust(spell:getID())

    -- Records of Eminence: Call Forth an Alter Ego
    if caster:getEminenceProgress(932) then
        xi.roe.onRecordTrigger(caster, 932)
    end

    return 0
end

-- page_offset is: (summon_message_id - 1) / 100
-- Example: Shantotto II summon message ID: 11201
-- page_offset: (11201 - 1) / 100 = 112
xi.trust.message = function(mob, message_offset)
    local poolID = mob:getPool()
    local page_offset = poolIDToMessagePageOffset[poolID]

    if page_offset == nil then
        print("trust.lua: pageOffset not set for Trust poolID: " .. poolID)
        return
    end

    if page_offset > MAX_MESSAGE_PAGE then
        print("trust.lua: MAX_MESSAGE_PAGE exceeded!")
        return
    end

    local trust_offset = xi.msg.system.GLOBAL_TRUST_OFFSET + (page_offset * 100)
    mob:trustPartyMessage(trust_offset + message_offset)
end

xi.trust.teamworkMessage = function(mob, teamwork_messages)
    local messages = {}

    local master = mob:getMaster()
    local party = master:getPartyWithTrusts()
    for _, member in pairs(party) do
        if member:getObjType() == xi.objType.TRUST then
            for id, message in pairs(teamwork_messages) do
                if member:getTrustID() == id then
                    table.insert(messages, message)
                end
            end
        end
    end

    if table.getn(messages) > 0 then
        xi.trust.message(mob, messages[math.random(#messages)])
    else
        -- Defaults to regular spawn message
        xi.trust.message(mob, xi.trust.message_offset.SPAWN)
    end
end

-- For debugging and lining up teamwork messages
xi.trust.dumpMessages = function(mob, pageOffset)
    for i=0, 20 do
        xi.trust.message(mob, pageOffset, i)
    end
end

xi.trust.dumpMessagePages = function(mob)
    for i=0, 120 do
        xi.trust.message(mob, i, xi.trust.message_offset.SPAWN)
    end
end
