__cop()   { rubocop $*; }
__copf()  { __cop --format=fuubar $*; }
__copp()  { __cop --parallel $*; }
__copac() { __cop --auto-correct $*; }
