#ifndef WAVEFRONT_OBJ_H

#define WAVEFRONT_OBJ_H

class WavefrontObj
{
public:
    WavefrontObj(void);
    ~WavefrontObj(void);

    unsigned int loadObj(const char* fname, bool textured); // load a wavefront obj returns number of triangles that were loaded.  Data is persists until the class is destructed.

    static bool saveObj(const char* fname, int vcount, const float* vertices, int tcount, const int* indices);

    int    mVertexCount;
    int    mTriCount;
    int*   mIndices;
    float* mVertices;
    float* mTexCoords;
};

#endif
