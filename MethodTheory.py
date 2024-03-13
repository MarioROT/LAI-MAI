f,g,P,Q = {},{},{},{}
f['o1'] = 'o2'
f['o2'] = 'o2'
g['o1'] = 'o1'
g['o2'] = 'o1'

P['o1'] = 1
P['o2'] = 1
Q['o1'] = 1
Q['o2'] = 0

p1 = P[f['o1']] and P[f['o2']]
p2 = (not P['o1'] or Q[g['o1']]) and (not P['o1'] or Q[g['o1']])
c = Q[f[g['o1']]] and Q[f[g['o2']]]

argument = 'INVALID' if ((p1 and p2) and (not c)) else 'VALID'

print(f'Premise 1 is: {p1}')
print(f'Premise 2 is: {p2}')
print(f'Conclusion is : {c}')
print(f'The argument is {argument}')

