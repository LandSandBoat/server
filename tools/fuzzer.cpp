#include <cstdint>
#include <cstddef>

// https://llvm.org/docs/LibFuzzer.html
// https://github.com/google/fuzzing/blob/master/docs/structure-aware-fuzzing.md

extern "C" int LLVMFuzzerTestOneInput(const uint8_t* Data, size_t Size)
{
    // TODO:
    //map_session_data_t map_session_data;
    //CCharEntity CChar;

    //auto packet = CBasicPacket(reinterpret_cast<uint8*>(Data));

    //PacketParser[SmallPD_Type](&map_session_data, &CChar, packet);

    return 0;
}
