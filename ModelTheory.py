import itertools

# Define the mappings for each variable
f_mapping = {'o1': 'o2', 'o2': 'o2'}
g_mapping = {'o1': 'o1', 'o2': 'o1'}
P_mapping = {'o1': 1, 'o2': 1}
Q_mapping = {'o1': 1, 'o2': 0}

# Generate all possible combinations for 'o1' and 'o2' separately
o1_combinations = list(itertools.product(f_mapping.keys(), g_mapping.keys(), P_mapping.keys(), Q_mapping.keys()))
o2_combinations = list(itertools.product(f_mapping.keys(), g_mapping.keys(), P_mapping.keys(), Q_mapping.keys()))

# Combine 'o1' and 'o2' combinations
combinations = []
for o1_comb in o1_combinations:
    for o2_comb in o2_combinations:
        combinations.append(o1_comb + o2_comb)

valids = 0
invalids = 0
# Print the combinations
for combination in combinations:
    print('\n #------------------------------------------------#')
    f,g,P,Q = {},{},{},{}
    f['o1'] = f_mapping[combination[0]]
    f['o2'] = f_mapping[combination[4]]
    g['o1'] = g_mapping[combination[1]]
    g['o2'] = g_mapping[combination[5]]

    P['o1'] = P_mapping[combination[2]]
    P['o2'] = P_mapping[combination[6]]
    Q['o1'] = Q_mapping[combination[3]]
    Q['o2'] = Q_mapping[combination[7]]

    print(f"Values --> f['o1'] = {f['o1']} - f['o2'] = {f['o2']} | g['o1'] = {g['o1']} - g['o2'] = {g['o2']} | P['o1'] = {P['o1']} - P['o2'] = {P['o2']} | Q['o1'] = {Q['o1']} - Q['o2'] = {Q['o2']}")

    p1 = P[f['o1']] and P[f['o2']]
    p2 = (not P['o1'] or Q[g['o1']]) and (not P['o1'] or Q[g['o1']])
    c = Q[f[g['o1']]] and Q[f[g['o2']]]

    argument = 'INVALID' if ((p1 and p2) and (not c)) else 'VALID'

    print(f'Premise 1 is: {p1}')
    print(f'Premise 2 is: {p2}')
    print(f'Conclusion is : {c}')
    print(f'The argument is {argument}')

    if argument == 'INVALID': invalids += 1
    else: valids += 1

print(f'Total valids: {valids} --- Total invalids: {invalids}')
