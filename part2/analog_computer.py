from lucipy import Circuit, LUCIDAC

a = 1.0  # Frequency

l = Circuit()  # Create a circuit

msin = l.int(ic=0)
mcos = l.int(ic=1)

l.connect(msin, mcos, weight=a)
l.connect(mcos, msin, weight=-a)

l.measure(msin, adc_channel=0)
l.measure(mcos, adc_channel=1)

hc = LUCIDAC()
hc.set_config(l.generate())
hc.start_run()

print(l)
