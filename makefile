
SRCS = main.cpp

OPT = -O3

PROGNAME = thing.exe

LIBS=sfml-graphics sfml-window sfml-system

LDFLAGS += $(LIBS:%=-l%)

DEPS:=$(patsubst %.cpp,%.d,$(SRCS))

-include $(DEPS)

default: all

all: $(PROGNAME)

run: .dummy $(PROGNAME)
	./$(PROGNAME)

%.o: %.d %.cpp
	$(CXX) $(OPT) -c $(@:%.o=%.cpp) -o $(@) $(CXXFLAGS)

%.d: %.cpp
	$(CXX) $(CXXFLAGS) -MM -MT '$(patsubst %.cpp,%.o,$<)' $< -MF $@

$(PROGNAME): $(SRCS:%.cpp=%.o)
	$(CXX) $(^) -o $(@) $(pkg-config --libs --cflags sfml-window sfml-system sfml-graphics)

.dummy:
