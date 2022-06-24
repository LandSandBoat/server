/************************************************************************
* Check Mob Module
*
* Changes Check mob back to 75 Era ranges. Removes Incredibly Easy Preys.
 ************************************************************************/

#include "map/utils/moduleutils.h"

#include "entities/charentity.h"
#include "entities/mobentity.h"
#include "map.h"
#include "mob_modifier.h"
#include "message.h"
#include "packet_system.h"
#include "utils/charutils.h"
#include "utils/jailutils.h"
#include "zone.h"

#include "packets/bazaar_message.h"
#include "packets/char_check.h"
#include "packets/message_standard.h"

extern uint8 PacketSize[512];
extern std::function<void(map_session_data_t* const, CCharEntity* const, CBasicPacket)> PacketParser[512];

class CheckMobModule : public CPPModule
{
    // era exp based mob checking
    EMobDifficulty CheckMob(uint8 charlvl, uint8 moblvl)
    {
        uint32 baseExp = charutils::GetBaseExp(charlvl, moblvl);

        if (baseExp >= 400) return EMobDifficulty::IncrediblyTough;   // 400+
        if (baseExp >= 200) return EMobDifficulty::VeryTough;         // 200 - 399
        if (baseExp > 100) return EMobDifficulty::Tough;              // 101 - 199
        if (baseExp == 100) return EMobDifficulty::EvenMatch;         // 100
        if (baseExp >= 80) return EMobDifficulty::DecentChallenge;    //  80 -  99
        if (baseExp >= 1) return EMobDifficulty::EasyPrey;            //   1 -  79

        return EMobDifficulty::TooWeak;
    }

    void OnInit() override
    {
        TracyZoneScoped;

        auto originalHandler = PacketParser[0x0DD];

        auto newHandler = [this, originalHandler](map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data) -> void
        {
            TracyZoneScoped;
            uint32 id     = data.ref<uint32>(0x04);
            uint16 targid = data.ref<uint16>(0x08);
            uint8  type   = data.ref<uint8>(0x0C);
            // for checkparam (0x02) use the original handler
            if (type == 0x02) {
                originalHandler(PSession, PChar, data);
            }
            else
            {
                // !!!
                // NOTE: This is almost the exact same code as the original, with CheckMob changed.
                //     : If the original code changes, this will have to change too!
                // !!!
                if (jailutils::InPrison(PChar))
                {
                    PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, 316));
                    return;
                }

                CBaseEntity* PEntity = PChar->GetEntity(targid, TYPE_MOB | TYPE_PC);

                if (PEntity == nullptr || PEntity->id != id)
                {
                    return;
                }

                switch (PEntity->objtype)
                {
                    case TYPE_MOB:
                    {
                        CMobEntity* PTarget = (CMobEntity*)PEntity;

                        if (PTarget->m_Type & MOBTYPE_NOTORIOUS || PTarget->m_Type & MOBTYPE_BATTLEFIELD || PTarget->getMobMod(MOBMOD_CHECK_AS_NM) > 0)
                        {
                            PChar->pushPacket(new CMessageBasicPacket(PChar, PTarget, 0, 0, 249));
                        }
                        else
                        {
                            uint8          mobLvl   = PTarget->GetMLevel();
                            // new era CheckMob as defined at top of file
                            EMobDifficulty mobCheck = CheckMob(PChar->GetMLevel(), mobLvl);
                            // retail CheckMob in charutils.cpp
                            // EMobDifficulty mobCheck = charutils::CheckMob(PChar->GetMLevel(), mobLvl);

                            // Calculate main /check message (64 is Too Weak)
                            int32 MessageValue = 64 + (uint8)mobCheck;

                            // Grab mob and player stats for extra messaging
                            uint16 charAcc = PChar->ACC(SLOT_MAIN, (uint8)0);
                            uint16 charAtt = PChar->ATT();
                            uint16 mobEva  = PTarget->EVA();
                            uint16 mobDef  = PTarget->DEF();

                            // Calculate +/- message
                            uint16 MessageID = 174; // Default even def/eva

                            // Offsetting the message ID by a certain amount for each stat gives us the correct message
                            // Defense is +/- 1
                            // Evasion is +/- 3
                            if (mobDef > charAtt)
                            { // High Defesne
                                MessageID -= 1;
                            }
                            else if ((mobDef * 1.25) <= charAtt)
                            { // Low Defense
                                MessageID += 1;
                            }

                            if ((mobEva - 30) > charAcc)
                            { // High Evasion
                                MessageID -= 3;
                            }
                            else if ((mobEva + 10) <= charAcc)
                            {
                                MessageID += 3;
                            }

                            PChar->pushPacket(new CMessageBasicPacket(PChar, PTarget, mobLvl, MessageValue, MessageID));
                        }
                    }
                    break;
                    case TYPE_PC:
                    {
                        CCharEntity* PTarget = (CCharEntity*)PEntity;

                        if (!PChar->m_isGMHidden || (PChar->m_isGMHidden && PTarget->m_GMlevel >= PChar->m_GMlevel))
                        {
                            PTarget->pushPacket(new CMessageStandardPacket(PChar, 0, 0, MsgStd::Examine));
                        }

                        PChar->pushPacket(new CBazaarMessagePacket(PTarget));
                        PChar->pushPacket(new CCheckPacket(PChar, PTarget));
                    }
                    break;
                    default:
                    {
                        break;
                    }
                }
            }
        };

        PacketParser[0x0DD] = newHandler;
    }
};

REGISTER_CPP_MODULE(CheckMobModule);
